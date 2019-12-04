<?php

$di['router'] = function() use ($defaultModule, $modules, $di, $config) {

	$router = new \Phalcon\Mvc\Router(false);
	$router->clear();

	/**
	 * Default Routing
	 */
	$router->add('/', [
	    'namespace' => $modules[$defaultModule]['webControllerNamespace'],
		'module' => $defaultModule,
	    'controller' => isset($modules[$defaultModule]['defaultController']) ? $modules[$defaultModule]['defaultController'] : 'index',
	    'action' => isset($modules[$defaultModule]['defaultAction']) ? $modules[$defaultModule]['defaultAction'] : 'index'
	]);

	$router->addGet('/brand', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'brand',
	    'action' => 'index'
	]);

	$router->addPost('/brand', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'brand',
	    'action' => 'store'
	]);

	$router->addGet('/brand/{brand}/edit', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'brand',
	    'action' => 'edit'
	]);

	$router->addPost('/brand/{brand}/update', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'brand',
	    'action' => 'update'
	]);

	$router->addPost('/brand/{brand}/destroy', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'brand',
	    'action' => 'destroy'
	]);




	$router->addGet('/goods', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'goods',
	    'action' => 'index'
	]);

	$router->addPost('/goods', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'goods',
	    'action' => 'store'
	]);

	$router->addGet('/goods/{goods}/edit', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'goods',
	    'action' => 'edit'
	]);

	$router->addPost('/goods/{goods}/update', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'goods',
	    'action' => 'update'
	]);

	$router->addPost('/goods/{goods}/destroy', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'goods',
	    'action' => 'destroy'
	]);

	$router->addPost('/inflow/store', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'goodsinflow',
	    'action' => 'store'
	]);

	$router->addPost('/outflow/store', [
	    'namespace' => 'StockMan\Goods\Controllers\Web',
		'module' => 'goods',
	    'controller' => 'goodsoutflow',
	    'action' => 'store'
	]);


	
	/**
	 * Not Found Routing
	 */
	$router->notFound(
		[
			// 'namespace' => 'Phalcon\Init\Common\Controllers',
			// 'controller' => 'base',
			// 'action'     => 'route404',
			'namespace' => 'StockMan\Common\Controllers',
			'controller' => 'base',
			'action'     => 'route404',
		]
	);

	/**
	 * Module Routing
	 */
	foreach ($modules as $moduleName => $module) {

		if ($module['defaultRouting'] == true) {
			/**
			 * Default Module routing
			 */
			$router->add('/'. $moduleName . '/:params', array(
				'namespace' => $module['webControllerNamespace'],
				'module' => $moduleName,
				'controller' => isset($module['defaultController']) ? $module['defaultController'] : 'index',
				'action' => isset($module['defaultAction']) ? $module['defaultAction'] : 'index',
				'params'=> 1
			));
			
			$router->add('/'. $moduleName . '/:controller/:params', array(
				'namespace' => $module['webControllerNamespace'],
				'module' => $moduleName,
				'controller' => 1,
				'action' => isset($module['defaultAction']) ? $module['defaultAction'] : 'index',
				'params' => 2
			));

			$router->add('/'. $moduleName . '/:controller/:action/:params', array(
				'namespace' => $module['webControllerNamespace'],
				'module' => $moduleName,
				'controller' => 1,
				'action' => 2,
				'params' => 3
			));	

			/**
			 * Default API Module routing
			 */
			$router->add('/'. $moduleName . '/api/{version:^(\d+\.)?(\d+\.)?(\*|\d+)$}/:params', array(
				'namespace' => $module['apiControllerNamespace'] . "\\" . 1,
				'module' => $moduleName,
				'version' => 1,
				'controller' => isset($module['defaultController']) ? $module['defaultController'] : 'index',
				'action' => isset($module['defaultAction']) ? $module['defaultAction'] : 'index',
				'params'=> 2
			));
			
			$router->add('/'. $moduleName . '/api/{version:^(\d+\.)?(\d+\.)?(\*|\d+)$}/:controller/:params', array(
				'namespace' => $module['apiControllerNamespace'] . "\\" . 1,
				'module' => $moduleName,
				'version' => 1,
				'controller' => 2,
				'action' => isset($module['defaultAction']) ? $module['defaultAction'] : 'index',
				'params' => 3
			));

			$router->add('/'. $moduleName . '/api/{version:^(\d+\.)?(\d+\.)?(\*|\d+)$}/:controller/:action/:params', array(
				'namespace' => $module['apiControllerNamespace'] . "\\" . 1,
				'module' => $moduleName,
				'version' => 1,
				'controller' => 2,
				'action' => 3,
				'params' => 4
			));	
		} else {
			
			$webModuleRouting = APP_PATH . '/modules/'. $moduleName .'/config/routes/web.php';
			
			if (file_exists($webModuleRouting) && is_file($webModuleRouting)) {
				include $webModuleRouting;
			}

			$apiModuleRouting = APP_PATH . '/modules/'. $moduleName .'/config/routes/api.php';
			
			if (file_exists($apiModuleRouting) && is_file($apiModuleRouting)) {
				include $apiModuleRouting;
			}
		}
	}
	
    $router->removeExtraSlashes(true);
    
	return $router;
};