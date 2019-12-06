<?php

namespace StockMan\Goods\Controllers\Web;

use Phalcon\Mvc\Controller;
use StockMan\Goods\Models\Goods;
use StockMan\Goods\Models\GoodsInflow;
use \DataTables\DataTable;
use \Carbon\Carbon as Carbon;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class GoodsInflowController extends Controller
{
    public function indexAction()
    {
        if ($this->request->isAjax()) {
            if(!empty($this->request->getPost('from_date')) && !empty($this->request->getPost('to_date'))){
                $date_from = Carbon::parse($this->request->getPost('from_date'))->startOfDay();
                $date_to = Carbon::parse($this->request->getPost('to_date'))->endOfDay();

                $query = 'SELECT gi.id, gi.user_id, g.name, gi.quantity, gi.cur_stock, gi.detail, gi.updated_at, gi.purchase_price 
                            FROM \StockMan\Goods\Models\GoodsInflow as gi 
                            JOIN \StockMan\Goods\Models\Goods as g 
                            WHERE gi.goods_id = g.id
                            AND gi.created_at >= "'."$date_from".'" 
                            AND gi.created_at <= "'."$date_to".'"'.'';
                $resultset = $this->modelsManager
                            ->createQuery($query)
                            ->execute();
            }else {
                $query = "
                SELECT gi.id, gi.user_id, g.name, gi.quantity, gi.cur_stock, gi.detail, gi.updated_at, gi.purchase_price 
                FROM \StockMan\Goods\Models\GoodsInflow as gi
                JOIN \StockMan\Goods\Models\Goods as g 
                WHERE gi.goods_id = g.id";
                $resultset  = $this->modelsManager
                            ->createQuery($query)
                            ->execute();
            }

            $dataTables = new DataTable();

            $dataTables->fromResultSet($resultset)->sendResponse();
        }

        $this->view->pick('views/inflow/index');
    }

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