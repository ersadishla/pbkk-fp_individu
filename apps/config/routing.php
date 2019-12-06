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

	/**
	 * Brand Routing
	 */
	$brand = new \Phalcon\Mvc\Router\Group(
		[
			'namespace' => 'StockMan\Goods\Controllers\Web',
			'module'     => 'goods',
			'controller' => 'brand',
		]
	);

	$brand->setPrefix('/brand');

	$brand->addGet('', [
	    'action' => 'index'
	]);
	$brand->addPost('', [
	    'action' => 'store'
	]);
	$brand->addGet('/{brand}/edit', [
	    'action' => 'edit'
	]);
	$brand->addPost('/{brand}/update', [
	    'action' => 'update'
	]);
	$brand->addPost('/{brand}/destroy', [
	    'action' => 'destroy'
	]);
	$router->mount($brand);


	/**
	 * Goods Routing
	 */
	$goods = new \Phalcon\Mvc\Router\Group(
		[
			'namespace' => 'StockMan\Goods\Controllers\Web',
			'module'     => 'goods',
			'controller' => 'goods',
		]
	);

	$goods->setPrefix('/goods');

	$goods->addGet('', [
	    'action' => 'index'
	]);
	$goods->addPost('', [
	    'action' => 'store'
	]);
	$goods->addGet('/{goods}/edit', [
	    'action' => 'edit'
	]);
	$goods->addPost('/{goods}/update', [
	    'action' => 'update'
	]);
	$goods->addPost('/{goods}/destroy', [
	    'action' => 'destroy'
	]);
	$router->mount($goods);


	/**
	 * GoodsInflow Routing
	 */
	$inflow = new \Phalcon\Mvc\Router\Group(
		[
			'namespace' => 'StockMan\Goods\Controllers\Web',
			'module'     => 'goods',
			'controller' => 'goodsinflow',
		]
	);

	$inflow->setPrefix('/inflow');

	$inflow->addGet('', [
	    'action' => 'index'
	]);
	$inflow->addPost('', [
	    'action' => 'index'
	]);
	$inflow->addPost('/store', [
	    'action' => 'store'
	]);
	$router->mount($inflow);

	/**
	 * GoodsOutflow Routing
	 */
	$outflow = new \Phalcon\Mvc\Router\Group(
		[
			'namespace' => 'StockMan\Goods\Controllers\Web',
			'module'     => 'goods',
			'controller' => 'goodsoutflow',
		]
	);

	$outflow->setPrefix('/outflow');

	$outflow->addGet('', [
	    'action' => 'index'
	]);
	$outflow->addPost('', [
	    'action' => 'index'
	]);
	$outflow->addPost('/store', [
	    'action' => 'store'
	]);
	$router->mount($outflow);



	/**
	 * Recommedation Routing
	 */
	$recom = new \Phalcon\Mvc\Router\Group(
		[
			'namespace' => 'StockMan\Goods\Controllers\Web',
			'module'     => 'goods',
			'controller' => 'recommend',
		]
	);

	$recom->setPrefix('/recommend');

	$recom->addGet('', [
	    'action' => 'index'
	]);

	$recom->addPost('', [
	    'action' => 'index'
	]);

	$recom->addPost('/store', [
		'action' => 'store'
	]);

	$recom->addGet('/{recommend}/edit', [
	    'action' => 'edit'
	]);	

	$recom->addPost('/{recommend}/update', [
	    'action' => 'update'
	]);

	$recom->addPost('/{recommend}/destroy', [
	    'action' => 'destroy'
	]);

	$recom->addPost('/{recommend}/refresh', [
	    'action' => 'refresh'
	]);
	$router->mount($recom);

	/**
	 * Filter Routing
	 */
	$filter = new \Phalcon\Mvc\Router\Group(
		[
			'namespace' => 'StockMan\Goods\Controllers\Web',
			'module'     => 'goods',
			'controller' => 'filter',
		]
	);

	$filter->setPrefix('/filter');

	$filter->addGet('/minimal', [
	    'action' => 'minimal'
	]);

	$filter->addPost('/minimal', [
	    'action' => 'minimal'
	]);

	$filter->addGet('/empty', [
	    'action' => 'empty'
	]);

	$filter->addPost('/empty', [
	    'action' => 'empty'
	]);
	$router->mount($filter);



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