<?php

namespace StockMan\Goods\Validator;

use Phalcon\Validation;
use Phalcon\Validation\Validator\Numericality;
use Phalcon\Validation\Validator\PresenceOf;

class GoodsStoreValidation extends Validation
{
    public function initialize()
    {
        $this->add(
            'brand_id',
            new PresenceOf(
                [
                    'message' => 'Merk Barang wajib diisi',
                ]
            )
        );

        $this->add(
            'name',
            new PresenceOf(
                [
                    'message' => 'Nama Barang wajib diisi',
                ]
            )
        );

        $this->add(
            'type',
            new PresenceOf(
                [
                    'message' => 'Jenis Barang wajib diisi',
                ]
            )
        );

        $this->add(
            'volume',
            new Numericality(
                [
                    'message' => 'Volume Barang wajib berupa numerik',
                ]
            )
        );

        $this->add(
            'volume',
            new PresenceOf(
                [
                    'message' => 'Volume Barang wajib diisi',
                ]
            )
        );

        $this->add(
            'stock',
            new Numericality(
                [
                    'message' => 'Stok Barang wajib berupa numerik',
                ]
            )
        );

        $this->add(
            'stock',
            new PresenceOf(
                [
                    'message' => 'Stok Barang wajib diisi',
                ]
            )
        );

        $this->add(
            'min_stock',
            new Numericality(
                [
                    'message' => 'Stok Minimal Barang wajib berupa numerik',
                ]
            )
        );

        $this->add(
            'min_stock',
            new PresenceOf(
                [
                    'message' => 'Stok Minimal Barang wajib diisi',
                ]
            )
        );

        $this->add(
            'last_purchase_price',
            new Numericality(
                [
                    'message' => 'Harga Beli Barang wajib berupa numerik',
                ]
            )
        );

        $this->add(
            'last_purchase_price',
            new PresenceOf(
                [
                    'message' => 'Harga Beli Barang wajib diisi',
                ]
            )
        );
    }
}