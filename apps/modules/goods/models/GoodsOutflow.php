<?php

namespace StockMan\Goods\Models;

// use Phalcon\Mvc\Model;
use StockMan\Goods\Models\AutoDate;

class GoodsOutflow extends AutoDate
{
    public $user_id;
    public $goods_id;
    public $quantity;
    public $cur_stock;
    public $detail;

	public function initialize()
    {
        $this->setSource('goods_outflows');

        $this->belongsTo(
            'goods_id',
            'Goods',
            'id'
        );
    }
}