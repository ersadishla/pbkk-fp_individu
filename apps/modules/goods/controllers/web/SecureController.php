<?php

namespace StockMan\Goods\Controllers\Web;

use Phalcon\Mvc\Controller;

class SecureController extends Controller
{
    public function beforeExecuteRoute()
    {
        if(!$this->session->has('auth')){
            return $this->response->redirect('login');
        }
    }

    protected function back() {
        return $this->response->redirect($_SERVER['HTTP_REFERER']);
    }
}
