<?php

namespace StockMan\User\Models;

use Phalcon\Mvc\Model;

class User extends Model
{
    public $role_id;
    public $name;
    public $username;
    public $email;
    public $password;
    public $created_at;
    public $updated_at;

	public function initialize()
    {
        $this->setSource('users');

    }

    // public function getPassword()
    // {
    //     return $this->password;
    // }

    // public function setPassword($password)
    // {
    //     $this->password = $password;
    // }

    public function beforeCreate()
    {
        $this->created_at = date('Y-m-d h:i:s');
        $this->updated_at = date('Y-m-d h:i:s');
    }

    public function beforeUpdate()
    {
        $this->updated_at = date('Y-m-d h:i:s');
    }
}