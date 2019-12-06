<?php

namespace StockMan\Goods\Controllers\Web;

use Phalcon\Mvc\Controller;
use StockMan\Goods\Models\Goods;
use StockMan\Goods\Models\Recommend;
use \DataTables\DataTable;
use \Carbon\Carbon as Carbon;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class RecommendController extends Controller
{
    public function indexAction()
    {
        if ($this->request->isAjax()){
            $resultset  = $this->modelsManager
                            ->createQuery("SELECT   g.id as gid,
                                                    g.name,
                                                    g.type,
                                                    g.volume,
                                                    g.updated_at,
                                                    g.last_purchase_price,
                                                    r.id as rid,
                                                    r.variant,
                                                    r.normal_profit,
                                                    r.normal_price,
                                                    r.market_price,
                                                    r.recommend_price,
                                                    r.profit,
                                                    r.last_profit,
                                                    r.last_price
                                            FROM \StockMan\Goods\Models\Goods as g
                                            LEFT JOIN StockMan\Goods\Models\Recommend r
                                            ON g.id = r.goods_id")
                            ->execute();

            $dataTables = new DataTable();

            $dataTables->fromResultSet($resultset)->sendResponse();
        }

        $this->view->pick('views/recommend/index');
    }

    public function storeAction()
    {
        $valid = new Validation();

        $valid->add(
            'variant',
            new PresenceOf()
        );

        $valid->add(
            'package',
            new PresenceOf()
        );

        $valid->add(
            'last_price',
            new PresenceOf()
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
            $recommend = new Recommend;

            $recommend->goods_id = $this->request->getPost('goods_id');
            $recommend->variant = $this->request->getPost('variant');
            $recommend->modal = $this->request->getPost('modal'); 
            $recommend->package = $this->request->getPost('package'); 
            $recommend->hpp = $this->request->getPost('hpp'); 
            $recommend->normal_profit = $this->request->getPost('normal_profit');
            $recommend->normal_price = $this->request->getPost('normal_price');
            $recommend->market_price = $this->request->getPost('market_price');
            $recommend->recommend_price = $this->request->getPost('recommend_price');
            $recommend->profit = $this->request->getPost('profit');
            $recommend->last_price = $this->request->getPost('last_price');
            $recommend->last_profit = $this->request->getPost('last_profit');

            $recommend->save();
    
            $this->response->setJsonContent([
                'success' => 'Rekomendasi Harga berhasil ditambahkan'
            ])->send();
        }
    }

    public function editAction($id)
    {
        $recom = Recommend::findFirst($id)->toArray();
        $goods = Recommend::findFirst($id)->getGoods();
        $recom['name'] = $goods->name;
        $recom['volume'] = $goods->volume;
        $recom['last_purchase_price'] = $goods->last_purchase_price;

        $this->response->setJsonContent($recom)->send();
        # code...
    }

    public function updateAction($id)
    {
        $valid = new Validation();

        $valid->add(
            'variant',
            new PresenceOf()
        );

        $valid->add(
            'package',
            new PresenceOf()
        );

        $valid->add(
            'last_price',
            new PresenceOf()
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
            $recommend = Recommend::findFirst($id);

            $recommend->goods_id = $this->request->getPost('goods_id');
            $recommend->variant = $this->request->getPost('variant');
            $recommend->modal = $this->request->getPost('modal'); 
            $recommend->package = $this->request->getPost('package'); 
            $recommend->hpp = $this->request->getPost('hpp'); 
            $recommend->normal_profit = $this->request->getPost('normal_profit');
            $recommend->normal_price = $this->request->getPost('normal_price');
            $recommend->market_price = $this->request->getPost('market_price');
            $recommend->recommend_price = $this->request->getPost('recommend_price');
            $recommend->profit = $this->request->getPost('profit');
            $recommend->last_price = $this->request->getPost('last_price');
            $recommend->last_profit = $this->request->getPost('last_profit');

            $recommend->save();
    
            $this->response->setJsonContent([
                'success' => 'Rekomendasi Harga berhasil diperbarui'
            ])->send();
        }
        # code...
    }

    public function destroyAction($id)
    {
        $recom = Recommend::findFirst($id);

        $recom->delete();

        $this->response->setJsonContent([
            'success' => 'Rekomendasi Harga berhasil dihapus'
        ])->send();
    }

    public function refreshAction($id)
    {
        $recom = Goods::findFirst($id)->getRecommend();
        $goods = Goods::findFirst($id);

        foreach($recom as $recommend)
        {
            $recommend->modal = $goods->last_purchase_price * $recommend->variant / $goods->volume;
            $recommend->hpp = $recommend->modal + $recommend->package; 
            $recommend->normal_profit = 0.3 * $recommend->hpp;
            $recommend->normal_price = $recommend->modal + $recommend->normal_profit + $recommend->package;
            if($recommend->normal_price < $recommend->market_price){
                $recommend->recommend_price = $recommend->market_price - 1000;
            }else if($recommend->normal_price > $recommend->market_price){
                $recommend->recommend_price = $recommend->market_price;
            }
            $recommend->profit = $recommend->recommend_price - $recommend->hpp;
            $recommend->last_profit = $recommend->last_price - $recommend->hpp;

            $recommend->update();
        }

        $this->response->setJsonContent([
            'success' => 'Rekomendasi Harga berhasil disesuaikan'
        ])->send();
    }
}