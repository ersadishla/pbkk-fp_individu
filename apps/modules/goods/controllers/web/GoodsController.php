<?php

namespace StockMan\Goods\Controllers\Web;

use Phalcon\Mvc\Controller;
use StockMan\Goods\Models\Brand;
use StockMan\Goods\Models\Goods;
use StockMan\Goods\Validator\GoodsStoreValidation;
use StockMan\Goods\Validator\GoodsUpdateValidation;
use \DataTables\DataTable;

class GoodsController extends Controller
{
    public function indexAction()
    {
        if ($this->request->isAjax()) {
            $resultset  = $this->modelsManager
                            ->createQuery("SELECT * FROM \StockMan\Goods\Models\Goods")
                            ->execute();

            $dataTables = new DataTable();

            $dataTables->fromResultSet($resultset)->sendResponse();
        }

        $this->view->brands = Brand::find();

        $this->view->pick('views/goods/index');
    }
    
    public function storeAction()
    {
        $valid = new GoodsStoreValidation();

        $messages = $valid->validate($this->request->getPost());

        $data = [];
        foreach ($messages as $message) {
            $data[$message->getField()] = $message->getMessage();
        }
        
        if (count($data) > 0) {
            $this->response->setJsonContent([
                'errors' => $data
            ])->send();
        }else {
            $volume = (float)str_replace('.', '', $this->request->getPost('volume'));
            $stock = (float)str_replace('.', '', $this->request->getPost('stock'));
            $min_stock = (float)str_replace('.', '', $this->request->getPost('min_stock'));
            $last_purchase_price = (float)str_replace('.', '', $this->request->getPost('last_purchase_price'));

            $goods = new Goods;
    
            $goods->brand_id = $this->request->getPost('brand_id');
            $goods->name = $this->request->getPost('name');
            $goods->type = $this->request->getPost('type');
            $goods->volume = $volume;
            $goods->stock = $stock;
            $goods->min_stock = $min_stock;
            $goods->last_purchase_price = $last_purchase_price;

            $goods->save();
    
            $this->response->setJsonContent([
                'success' => 'Barang berhasil ditambahkan'
            ])->send();
        }
    }

    public function editAction($id)
    {
        $goods = Goods::findFirst($id);

        $this->response->setJsonContent([
            'id' => $id,
            'brand_id' => $goods->brand_id,
            'name' => $goods->name,
            'type' => $goods->type,
            'volume' => $goods->volume,
            'stock' => $goods->stock,
            'min_stock' => $goods->min_stock,
            'last_purchase_price' => $goods->last_purchase_price
        ])->send();
    }

    public function updateAction($id)
    {
        $valid = new GoodsUpdateValidation();

        $messages = $valid->validate($this->request->getPost());

        $data = [];
        foreach ($messages as $message) {
            $data[$message->getField()] = $message->getMessage();
        }
        
        if (count($data) > 0) {
            $this->response->setJsonContent([
                'errors' => $data
            ])->send();
        }else {
            $volume = (float)str_replace('.', '', $this->request->getPost('volume'));
            $stock = (float)str_replace('.', '', $this->request->getPost('stock'));
            $min_stock = (float)str_replace('.', '', $this->request->getPost('min_stock'));
            $last_purchase_price = (float)str_replace('.', '', $this->request->getPost('last_purchase_price'));

            $goods = Goods::findFirst($id);
    
            $goods->brand_id = $this->request->getPost('brand_id');
            $goods->name = $this->request->getPost('name');
            $goods->type = $this->request->getPost('type');
            $goods->volume = $volume;
            $goods->min_stock = $min_stock;

            $goods->save();
    
            $this->response->setJsonContent([
                'success' => 'Barang berhasil diperbarui'
            ])->send();
        }
    }

    public function destroyAction($id)
    {
        $goods = Goods::findFirst($id);

        $goods->delete();

        $this->response->setJsonContent([
            'success' => 'Barang berhasil dihapus'
        ])->send();
        # code...
    }

}