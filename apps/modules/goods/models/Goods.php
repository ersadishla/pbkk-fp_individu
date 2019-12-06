<?php

namespace StockMan\Goods\Models;

// use Phalcon\Mvc\Model;
use StockMan\Goods\Models\AutoDate;

class Goods extends AutoDate
{
    public $brand_id;
    public $name;
    public $type;
    public $volume;
    public $stock;
    public $min_stock;
    public $last_purchase_price;

	public function initialize()
    {
        $this->setSource('goods');

        $this->belongsTo(
            'brand_id',
            'StockMan\Goods\Models\Brand',
            'id',
            [
                'alias' => 'Brand',
            ]
        );

        $this->hasMany(
            'id',
            'StockMan\Goods\Models\GoodsInflows',
            'goods_id',
            [
                'alias' => 'GoodsInflows',
            ]
        );

        $this->hasMany(
            'id',
            'StockMan\Goods\Models\GoodsOutflows',
            'goods_id',
            [
                'alias' => 'GoodsOutflows',
            ]
        );

        $this->hasMany(
            'id',
            'StockMan\Goods\Models\Recommend',
            'goods_id',
            [
                'alias' => 'Recommend',
            ]
        );
    }
}