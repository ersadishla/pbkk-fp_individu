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
            'Brand',
            'id'
        );
    }
}