<?php

namespace Phalcon\Init\Dashboard\Controllers\Web;

use Phalcon\Mvc\Controller;

class DashboardController extends Controller
{
    public function indexAction()
    {
    	if(!$this->session->has('auth')){
    		return $this->response->redirect('login');
        }
        return $this->response->redirect('goods');
    }
}