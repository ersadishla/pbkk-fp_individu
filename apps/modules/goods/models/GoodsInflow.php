<?php

namespace StockMan\Goods\Models;

// use Phalcon\Mvc\Model;
use StockMan\Goods\Models\AutoDate;

class GoodsInflow extends AutoDate
{
    public $user_id;
    public $goods_id;
    public $quantity;
    public $cur_stock;
    public $detail;
    public $purchase_price;

	public function initialize()
    {
        $this->setSource('goods_inflows');

        $this->belongsTo(
            'goods_id',
            'StockMan\Goods\Models\Goods',
            'id',
            [
                'alias' => 'Goods',
            ]
        );
    }
}