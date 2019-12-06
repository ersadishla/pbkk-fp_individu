<?php

namespace StockMan\Goods\Controllers\Web;

use Phalcon\Mvc\Controller;
use StockMan\Goods\Models\Goods;
use StockMan\Goods\Models\GoodsOutflow;
use \DataTables\DataTable;
use \Carbon\Carbon as Carbon;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class GoodsOutflowController extends Controller
{
    public function indexAction()
    {
        if ($this->request->isAjax()) {
            if(!empty($this->request->getPost('from_date')) && !empty($this->request->getPost('to_date'))){
                $date_from = Carbon::parse($this->request->getPost('from_date'))->startOfDay();
                $date_to = Carbon::parse($this->request->getPost('to_date'))->endOfDay();

                $query = 'SELECT go.id, go.user_id, g.name, go.quantity, go.cur_stock, go.detail, go.updated_at
                            FROM \StockMan\Goods\Models\GoodsOutflow as go 
                            JOIN \StockMan\Goods\Models\Goods as g 
                            WHERE go.goods_id = g.id
                            AND go.created_at >= "'."$date_from".'" 
                            AND go.created_at <= "'."$date_to".'"'.'';
                $resultset = $this->modelsManager
                            ->createQuery($query)
                            ->execute();
            }else {
                $query = "
                SELECT go.id, go.user_id, g.name, go.quantity, go.cur_stock, go.detail, go.updated_at
                FROM \StockMan\Goods\Models\GoodsOutflow as go
                JOIN \StockMan\Goods\Models\Goods as g 
                WHERE go.goods_id = g.id";
                $resultset  = $this->modelsManager
                            ->createQuery($query)
                            ->execute();
            }

            $dataTables = new DataTable();

            $dataTables->fromResultSet($resultset)->sendResponse();
        }

        $this->view->pick('views/outflow/index');
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

            $goods = Goods::findFirst($this->request->getPost('goods_id'));

            $stock = $goods->stock - $quantity;

            if($stock < 0) {
                $this->response->setJsonContent([
                    'errors' => ['quantity' => 'Pengeluaran Barang melebihi stok']
                ])->send();
            }else {
                $goods->stock -= $quantity;

                $goods->save();

                $inflow = new GoodsOutflow;

                $inflow->user_id = 1;
                $inflow->goods_id = $this->request->getPost('goods_id');
                $inflow->quantity = $this->request->getPost('quantity');
                $inflow->cur_stock = $goods->stock;
                $inflow->detail = $this->request->getPost('detail');

                $inflow->save();

                $this->response->setJsonContent([
                    'success' => 'Pengeluaran Barang berhasil diselesaikan'
                ])->send();
            }

        }
        # code...
    }
}