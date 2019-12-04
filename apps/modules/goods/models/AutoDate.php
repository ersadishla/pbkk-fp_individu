<?php

namespace StockMan\Goods\Models;

use Phalcon\Mvc\Model;

class AutoDate extends Model
{
    public $created_at;
    public $updated_at;

    public function beforeCreate()
    {
        $this->created_at = date('Y-m-d h:i:s');
    }

    public function beforeUpdate()
    {
        $this->updated_at = date('Y-m-d h:i:s');
    }
}