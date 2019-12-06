<?php

namespace StockMan\Goods\Models;

// use Phalcon\Mvc\Model;
use StockMan\Goods\Models\AutoDate;

class Recommend extends AutoDate
{
    public $goods_id;
    public $variant;
    public $modal;
    public $package;
    public $hpp;
    public $normal_profit;
    public $normal_price;
    public $market_price;
    public $recommend_price;
    public $profit;
    public $last_price;
    public $last_profit;

	public function initialize()
    {
        $this->setSource('recommends');

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