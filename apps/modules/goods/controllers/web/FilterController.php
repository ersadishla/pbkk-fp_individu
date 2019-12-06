<?php

namespace StockMan\Goods\Controllers\Web;

use Phalcon\Mvc\Controller;
use StockMan\Goods\Models\Goods;
use \DataTables\DataTable;

class FilterController extends Controller
{
    public function minimalAction()
    {
        if ($this->request->isAjax()) {
            $resultset  = $this->modelsManager
                            ->createQuery("SELECT * FROM \StockMan\Goods\Models\Goods WHERE stock <= min_stock")
                            ->execute();

            $dataTables = new DataTable();

            $dataTables->fromResultSet($resultset)->sendResponse();
        }

        $this->view->pick('views/filter/minimal');
    }

    public function emptyAction()
    {
        if ($this->request->isAjax()) {
            $resultset  = $this->modelsManager
                            ->createQuery("SELECT * FROM \StockMan\Goods\Models\Goods WHERE stock <= 0")
                            ->execute();

            $dataTables = new DataTable();

            $dataTables->fromResultSet($resultset)->sendResponse();
        }

        $this->view->pick('views/filter/empty');
    }
}