<?php

$host="localhost";
$dbname="id11425759_isg";
$kullanici="id11425759_celalkutluer";
$sifre="*************";

try
{
    $db=new PDO("mysql:host=$host;dbname=$dbname;charset=utf8","$kullanici","$sifre");
}
catch (PDOException $e)
{
    print $e->getMessage();
}
//error_reporting(0);
session_start();
ob_start();
