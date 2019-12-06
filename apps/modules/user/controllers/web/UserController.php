<?php

namespace StockMan\User\Controllers\Web;

use Phalcon\Mvc\Controller;
use StockMan\User\Models\User;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;

class UserController extends Controller
{
    public function loginFormAction()
    {
        $this->view->pick('views/login');
    }

    public function loginAction()
    {
        $email = $this->request->getPost('email');
        $password = $this->request->getPost('password');

    	$check_user = User::findFirst(
            [
                "conditions" => "email = :email:",
                "bind" => [
                    "email"   => $email
                ],
            ]
        );
        // $this->session->set('auth', $check_user);
        // var_dump( $this->session->get('auth')); die();
        // var_dump($check_user); die();

        if($check_user === false){
            $this->flashSession->error("Email anda tidak terdaftar dalam sistem.");
            return $this->response->redirect('login');
        }else{
            if(!$this->security->checkHash($password, $check_user->password)){
                $this->flashSession->error("Password yang anda masukkan salah.");
                return $this->response->redirect('login');
            }
        }
        
        $this->session->set('auth', $check_user);
        return $this->response->redirect('');
    }

    public function registerFormAction()
    {
        $this->view->pick('views/register');
    }

    public function registerAction()
    {

        if($this->request->isPost())
        {
            $valid = new Validation();

            $valid->add(
                'name',
                new PresenceOf()
            );

            $valid->add(
                'username',
                new PresenceOf()
            );

            $valid->add(
                'email',
                new PresenceOf()
            );

            $valid->add(
                'password',
                new PresenceOf()
            );

            $is_valid = $valid->validate($this->request->getPost());

            if (count($is_valid) > 0) {
                $this->flashSession->error("Mohon lengkapi semua data.");
                return $this->response->redirect('register');
            }else{
                $data = $_POST;
                $user = new User;

                $check_user = User::findFirst(
                    [
                        "conditions" => "email = :email:",
                        "bind" => [
                            "email"   => $data['email']
                        ],
                    ]
                );
                if($check_user){
                    $this->flashSession->error("Email sudah digunakan.");
                    return $this->response->redirect('register');
                }else if($data['password'] != $data['password_confirmation']){
                    $this->flashSession->error("Konfirmasi password tidak sama.");
                    return $this->response->redirect('register');
                }else {
                    $user->role_id = 1;
                    $user->name = $data['name'];
                    $user->username = $data['username'];
                    $user->email = $data['email'];
                    $user->password($this->security->hash($data['password']));

                    $user->save();

                    $this->flashSession->success("Registrasi berhasil, silahkan Login.");
                    return $this->response->redirect('login')->send();
                }
                    
            }

        }
    }

    public function logoutAction()
    {
        $this->session->destroy();
        return $this->response->redirect('');
    }
}