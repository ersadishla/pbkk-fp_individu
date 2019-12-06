<?php

namespace StockMan\Goods\Controllers\Web;

// use Phalcon\Mvc\Controller;
use StockMan\Goods\Controllers\Web\SecureController;
use StockMan\Goods\Models\Brand;
use \DataTables\DataTable;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class BrandController extends SecureController
{

    public function indexAction()
    {
        if ($this->request->isAjax()) {
            $resultset  = $this->modelsManager
                            ->createQuery("SELECT * FROM \StockMan\Goods\Models\Brand")
                            ->execute();

            $dataTables = new DataTable();

            $dataTables->fromResultSet($resultset)->sendResponse();
        }
        
        $this->view->pick('views/brand/index');
    }

    public function storeAction()
    {
        $valid = new Validation();

        $valid->add(
            'name',
            new PresenceOf(
                [
                    'message' => 'Nama merk wajib diisi',
                ]
            )
        );

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
            $brand = new Brand;
    
            $brand->name = $this->request->getPost('name');
    
            $brand->save();
    
            $this->response->setJsonContent([
                'success' => 'Merk berhasil ditambahkan'
            ])->send();
        }
    }

    public function editAction($id)
    {
        $brand = Brand::findFirst($id);

        $this->response->setJsonContent([
            'id' => $id,
            'name' => $brand->name
        ])->send();
    }

    public function updateAction($id)
    {
        $valid = new Validation();

        $valid->add(
            'name',
            new PresenceOf(
                [
                    'message' => 'Nama merk wajib diisi',
                ]
            )
        );

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
            $brand = Brand::findFirst($id);

            $brand->name = $this->request->getPost('name');

            $brand->update();

            $this->response->setJsonContent([
                'success' => 'Merk berhasil diperbarui'
            ])->send();
        }
    }

    public function destroyAction($id)
    {
        $brand = Brand::findFirst($id);

        $brand->delete();

        $this->response->setJsonContent([
            'success' => 'Merk berhasil dihapus'
        ])->send();
        # code...
    }
}