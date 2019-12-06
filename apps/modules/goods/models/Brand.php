<?php

namespace StockMan\Goods\Models;

// use Phalcon\Mvc\Model;
use StockMan\Goods\Models\AutoDate;

class Brand extends AutoDate
{
    public $name;

	public function initialize()
    {
        $this->setSource('brands');

        $this->hasMany(
            'id',
            'StockMan\Goods\Models\Goods',
            'brand_id',
            [
                'alias' => 'Goods',
            ]
        );
    }


}