<?php

namespace StockMan\Goods\Controllers\Web;

use Phalcon\Mvc\Controller;
use StockMan\Goods\Models\Goods;
use StockMan\Goods\Models\GoodsInflow;
use \DataTables\DataTable;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class GoodsInflowController extends Controller
{
    public function storeAction()
    {
    
        $valid = new Validation();

        
        $valid->add(
            'goods_id',
            new PresenceOf(
                [
                    'message' => 'Nama Barang wajib diisi',
                ]
            )
        );

        $valid->add(
            'quantity',
            new PresenceOf(
                [
                    'message' => 'Jumlah Barang wajib diisi',
                ]
            )
        );

        $valid->add(
            'purchase_price',
            new PresenceOf(
                [
                    'message' => 'Harga Beli Barang wajib diisi',
                ]
            )
        );

        $messages = $valid->validate($valid->request->getPost());

        $data = [];
        foreach ($messages as $message) {
            $data[$message->getField()] = $message->getMessage();
        }
        
        if (count($data) > 0) {
            $this->response->setJsonContent([
                'errors' => $data
            ])->send();
        }else {
            $quantity = $this->request->getPost('quantity');

            $purchase_price = (float)str_replace('.', '', $this->request->getPost('purchase_price'));

            $goods = Goods::findFirst($this->request->getPost('goods_id'));

            $goods->stock += $quantity;
            $goods->last_purchase_price = $purchase_price;

            $goods->update();

            $inflow = new GoodsInflow;

            $inflow->user_id = 1;
            $inflow->goods_id = $this->request->getPost('goods_id');
            $inflow->quantity = $this->request->getPost('quantity');
            $inflow->cur_stock = $goods->stock;
            $inflow->detail = $this->request->getPost('detail');
            $inflow->purchase_price = $purchase_price;

            $inflow->save();
    
            $this->response->setJsonContent([
                'success' => 'Pemasukan Barang berhasil diselesaikan'
            ])->send();
        }
        # code...
    }
}