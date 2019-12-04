<?php

namespace StockMan\Goods;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\ModuleDefinitionInterface;

class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();

        $loader->registerNamespaces([
            'StockMan\Goods\Controllers\Web' => __DIR__ . '/controllers/web',
            'StockMan\Goods\Controllers\Api' => __DIR__ . '/controllers/api',
            'StockMan\Goods\Models' => __DIR__ . '/models',
            'StockMan\Goods\Validator' => __DIR__ . '/validations',
        ]);

        $loader->register();
    }

    public function registerServices(DiInterface $di = null)
    {
        $moduleConfig = require __DIR__ . '/config/config.php';

        $di->get('config')->merge($moduleConfig);

        include_once __DIR__ . '/config/services.php';
    }
}