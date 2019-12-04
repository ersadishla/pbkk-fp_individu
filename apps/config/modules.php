<?php

return array(
    'dashboard' => [
        'namespace' => 'Phalcon\Init\Dashboard',
        'webControllerNamespace' => 'Phalcon\Init\Dashboard\Controllers\Web',
        'apiControllerNamespace' => 'Phalcon\Init\Dashboard\Controllers\Api',
        'className' => 'Phalcon\Init\Dashboard\Module',
        'path' => APP_PATH . '/modules/dashboard/Module.php',
        'defaultRouting' => true,
        'defaultController' => 'dashboard',
        'defaultAction' => 'index'
    ],

    'goods' => [
        'namespace' => 'StockMan\Goods',
        'webControllerNamespace' => 'StockMan\Goods\Controllers\Web',
        'apiControllerNamespace' => 'StockMan\Goods\Controllers\Api',
        'className' => 'StockMan\Goods\Module',
        'path' => APP_PATH . '/modules/goods/Module.php',
        'defaultRouting' => false,
        'defaultController' => 'goods',
        'defaultAction' => 'index'
    ],
);