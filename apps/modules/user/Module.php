<?php

namespace StockMan\User;

use Phalcon\DiInterface;
use Phalcon\Loader;
use Phalcon\Mvc\ModuleDefinitionInterface;

class Module implements ModuleDefinitionInterface
{
    public function registerAutoloaders(DiInterface $di = null)
    {
        $loader = new Loader();

        $loader->registerNamespaces([
            'StockMan\User\Controllers\Web' => __DIR__ . '/controllers/web',
            'StockMan\User\Controllers\Api' => __DIR__ . '/controllers/api',
            'StockMan\User\Models' => __DIR__ . '/models',
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