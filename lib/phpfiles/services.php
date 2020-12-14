<?php
include "settings/baglantilar.php";
include_once "settings/fonksiyonlar.php";
date_default_timezone_set('Europe/Istanbul');
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=utf-8");

//http://celalkutluer.com.tr/services.php?kul_eposta=Y2VsYWxrdXRsdWVyQGdtYWlsLmNvbQ==&kul_sifre=NjZmNjdiZGQxYmY0NTI5NzQ2ODk4NzA5MGJlMzkyZTQ4MTA0MzdkZWZiMTIzYzQ3YjcxNWVhYzUxNzU5ZTVkOA==&s=MTYwNzExMjE0NzI3Mw==

//////////////////////////////////////////////////////////////////////////////////////////////
if (zamanHesapla(g('securityKey')) >= -5) {
    if (!empty(g('kul_eposta')) && !empty(g('kul_sifre')) && $_SERVER['REQUEST_METHOD'] == 'GET') {
        $eposta = base64_decode(g('kul_eposta'));
        $sifre = base64_decode(g('kul_sifre'));
        //////////////////////////////////////////////////
        // $ekle_log = $db->prepare("INSERT INTO log(log_ip, log_body) VALUES ('" . ipAl() . "','Kullanıcı eposta: " . $eposta .' Şifre : '.g('kul_sifre')."')");
        // $ekleme_log = $ekle_log->execute(array());
        //////////////////////////////////////////////////
        //echo 'ok';
        $veri = $db->prepare('SELECT * FROM kullanici where kul_eposta=? and sifre=?');
        $veri->execute(array($eposta, $sifre));
        $say = $veri->rowCount();
        $v = $veri->fetchAll(PDO::FETCH_ASSOC);
        foreach ($v as $bilgi) ;
        //echo  $eposta.'-';
        //echo $sifre.'-';
        // echo $say;
        if ($say == 1) {
            $token = createToken();
            $json_array['isLogin'] = true;
            $json_array['kul_id'] = $bilgi['id'];
            $json_array['token'] = $token;
            echo json_encode($json_array, JSON_UNESCAPED_UNICODE);
            $kul_token_guncelle = $db->prepare("UPDATE kullanici SET kul_token=? WHERE id=?");
            $kul_token_guncelleme = $kul_token_guncelle->execute(array($token, $bilgi['id']));
        } else {
            $json_array['isLogin'] = false;
            echo json_encode($json_array, JSON_UNESCAPED_UNICODE);
        }
    } elseif (!empty(g('kul_id')) && !empty(g('kul_token'))) {
        $veri = $db->prepare('SELECT * FROM kullanici where id=? and kul_token=?');
        $veri->execute(array(g('kul_id'), g('kul_token')));
        $say = $veri->rowCount();
        if ($say == 1) {
            if ($_SERVER['REQUEST_METHOD'] == 'GET') {
                // echo "kullanıcı ve token ok-";
                if (g('islem') == 'PersonelGetirAnaSayfa') {
                    //http://celalkutluer.com.tr/services.php?kul_id=1&token=a&securityKey=a&islem=PersonelGetirAnaSayfa
                    $veri = $db->prepare('SELECT id,per_tc,per_ad,per_soyad FROM personel ORDER BY per_ad ASC LIMIT 50');
                    $veri->execute();
                    $v = $veri->fetchAll(PDO::FETCH_ASSOC);
                    $say = $veri->rowCount();
                    $json_data = array();//create the array
                    foreach ($v as $personelGetirAnaSayfa) {
                        $json_array['id'] = base64_encode($personelGetirAnaSayfa['id']);
                        $json_array['per_tc'] = base64_encode($personelGetirAnaSayfa['per_tc']);
                        $json_array['per_ad_soyad'] = base64_encode($personelGetirAnaSayfa['per_ad'].' '.$personelGetirAnaSayfa['per_soyad']);
                        //$json_array['per_ad'] = base64_encode($personelGetirAnaSayfa['per_ad']);
                        //$json_array['per_soyad'] = base64_encode($personelGetirAnaSayfa['per_soyad']);

                        //here pushing the values in to an array
                        array_push($json_data, $json_array);
                    }
                    //built in PHP function to encode the data in to JSON format
                    echo json_encode($json_data, JSON_UNESCAPED_UNICODE);
                }
                elseif (g('islem') == 'PersonelDetayGetir') {
                    //http://celalkutluer.com.tr/services.php?kul_id=1&token=a&securityKey=a&islem=PersonelGetirAnaSayfa
                    $veri = $db->prepare('SELECT personel.id, personel.per_tc,personel.per_ad,personel.per_soyad,birim.birim_ad,altbirim.altbirim_ad,gorev.gorev_ad,egitim_derece.egitim_derece_ad
FROM personel
INNER JOIN birim on birim.id=personel.per_birim_id
INNER JOIN altbirim on  altbirim.id=personel.per_altbirim_id
INNER JOIN gorev on gorev.id=personel.per_gorev_id
INNER JOIN egitim_derece on egitim_derece.id=personel.per_egitim_derece_id
WHERE personel.id =? LIMIT 1');
                    $veri->execute(array(g('per_id')));
                    $v = $veri->fetchAll(PDO::FETCH_ASSOC);
                    $say = $veri->rowCount();
                    $json_data = array();//create the array
                    foreach ($v as $personelGetirAnaSayfa) {
                        $json_array['id'] = base64_encode($personelGetirAnaSayfa['id']);
                        $json_array['per_tc'] = base64_encode($personelGetirAnaSayfa['per_tc']);
                        $json_array['per_ad_soyad'] = base64_encode($personelGetirAnaSayfa['per_ad'].' '.$personelGetirAnaSayfa['per_soyad']);
                        $json_array['birim'] = base64_encode($personelGetirAnaSayfa['birim_ad']);
                        $json_array['altbirim'] = base64_encode($personelGetirAnaSayfa['altbirim_ad']);
                        $json_array['gorev'] = base64_encode($personelGetirAnaSayfa['gorev_ad']);
                        $json_array['egitim'] = base64_encode($personelGetirAnaSayfa['egitim_derece_ad']);

                        //here pushing the values in to an array
                        array_push($json_data, $json_array);
                    }
                    //built in PHP function to encode the data in to JSON format
                    echo json_encode($json_data, JSON_UNESCAPED_UNICODE);
                }
            } elseif ($_SERVER['REQUEST_METHOD'] == 'POST') {
            }
        } else {
            $json_array['isApiSecurity'] = true;
            $json_array['status'] = 'Hack attack detected.';
            $json_array['attackIP'] = ipAl();

            echo json_encode($json_array, JSON_UNESCAPED_UNICODE);
        }
    } else {
        $json_array['isApiSecurity'] = true;
        $json_array['status'] = 'Hack attack detected.';
        $json_array['attackIP'] = ipAl();

        echo json_encode($json_array, JSON_UNESCAPED_UNICODE);

    }
} else {
        $json_array['isApiSecurity'] = true;
        $json_array['status'] = 'Hack attack detected.';
        $json_array['attackIP'] = ipAl();

        echo json_encode($json_array, JSON_UNESCAPED_UNICODE);
}

mysqli_close($db);
?>
