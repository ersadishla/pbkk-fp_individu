{% extends '../layouts/app.volt' %}

{% block content %}
<div class="d-flex justify-content-between">
    <h1 class="h3 mb-2 text-gray-800">Daftar Barang</h1>
</div>
<hr>
<div class="card shadow mb-4">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="goods-table" cellspacing="0" width="100%">
                <div class="alert alert-danger" style="display:none"></div>
                <div class="alert alert-success" style="display:none"></div>
                <div class="d-flex justify-content-end">
                    <a href="#" onclick="addGoods()" class="btn btn-primary">
                        Tambah
                    </a>
                </div>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Brand</th>
                        <th>Nama</th>
                        <th>Jenis</th>
                        <th>Volume</th>
                        <th>Stok</th>
                        <th>Stok Minimal</th>
                        <th>Harga Beli</th>
                        <th width="10rem">Tanggal Stok</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
    
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-form">
    <div class="modal-dialog">
        <div class="modal-content">
            <form  method="post" class="form-horizontal" data-toggle="validator">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title font-weight-bold"></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- Modal body -->
                <div class="modal-body">
                    <input type="hidden" name="_method" value="">
                    <input type="hidden" name="_token" value="<?php echo $this->security->getToken() ?>">
                    <input type="hidden" id="id" name="id">
                    <div class="form-group row">
                        <label for="brand" class="col-md-3 col-form-label text-md-right">Merk</label>

                        <div class="col-md-7">
                            <select name="brand_id" id="brand_id" class="form-control select2">
                                <option value="" selected></option>
                                {% for brand in brands %}
                                <option value="{{brand.id}}">{{brand.name}}</option>
                                {% endfor %}
                            </select>
                            <span class="text-danger">
                                <small id="brand_id-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="name" class="col-md-3 col-form-label text-md-right">Nama</label>

                        <div class="col-md-7">
                            <input id="name" type="text" class="form-control" name="name" autofocus>
                            <span class="text-danger">
                                <small id="name-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="type" class="col-md-3 col-form-label text-md-right">Varian</label>

                        <div class="col-md-7">
                            <input id="type" type="text" class="form-control" name="type" >
                            <span class="text-danger">
                                <small id="type-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="volume" class="col-md-3 col-form-label text-md-right">Volume</label>

                        <div class="col-md-7">
                            <input id="volume" type="text" class="form-control" name="volume" >
                            <span class="text-danger">
                                <small id="volume-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="stock" class="col-md-3 col-form-label text-md-right">Stok</label>

                        <div class="col-md-7">
                            <input id="stock" type="text" class="form-control" name="stock" >
                            <span class="text-danger">
                                <small id="stock-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="min_stock" class="col-md-3 col-form-label text-md-right">Stok Minimal</label>

                        <div class="col-md-7">
                            <input id="min_stock" type="text" class="form-control" name="min_stock" >
                            <span class="text-danger">
                                <small id="min_stock-error"></small>
                            </span>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label for="last_purchase_price" class="col-md-3 col-form-label text-md-right">Harga Beli</label>

                        <div class="col-md-7">
                            <input id="last_purchase_price" type="text" class="form-control" name="last_purchase_price" >
                            <span class="text-danger">
                                <small id="last_purchase_price-error"></small>
                            </span>
                        </div>
                    </div>
                </div>
                
                <!-- Modal footer -->
                <div class="modal-footer">
                    <div class="col-md-9 offset-md-3">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            Kembali
                        </button>
                        <button type="button" class="btn btn-primary" id="form-submit">
                            Submit
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="flow-form">
    <div class="modal-dialog">
        <div class="modal-content">
            <form  method="post" class="form-horizontal" data-toggle="validator">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title font-weight-bold"></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- Modal body -->
                <div class="modal-body">
                    <input type="hidden" id="goods_id" name="goods_id">
                    <div id="info">
                        <div class="form-group row">
                            <label for="name_info" class="col-md-4 text-md-right">Nama</label>
    
                            <div class="col-md-7">
                                <div id="name_info"></div>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="stock_info" class="col-md-4 text-md-right">Stok</label>
    
                            <div class="col-md-7">
                                <div id="stock_info"></div>
                            </div>
                        </div>
    
                        <div class="form-group row">
                            <label for="purchase_info" class="col-md-4 text-md-right">Harga Beli Terakhir</label>
    
                            <div class="col-md-7">
                                <div id="purchase_info"></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="quantity" class="col-md-4 text-md-right">Jumlah</label>

                        <div class="col-md-7">
                            <input id="quantity" type="text" class="form-control" name="quantity">
                            <span class="text-danger">
                                <small id="quantity-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="detail" class="col-md-4 text-md-right">Keterangan</label>

                        <div class="col-md-7">
                            <input id="detail" type="text" class="form-control" name="detail">
                            <span class="text-danger">
                                <small id="detail-error"></small>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row purchase-form">
                        <label for="purchase_price" class="col-md-4 text-md-right">Harga Beli</label>

                        <div class="col-md-7">
                            <input id="purchase_price" type="text" class="form-control" name="purchase_price">
                            <span class="text-danger">
                                <small id="purchase_price-error"></small>
                            </span>
                        </div>
                    </div>

                    
                </div>
                
                <!-- Modal footer -->
                <div class="modal-footer">
                    <div class="col-md-9 offset-md-3">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            Kembali
                        </button>
                        <button type="button" class="btn btn-primary" id="flow-submit">
                            Submit
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
{% endblock %}

{% block js %}

<script>
    $('.select2').select2({
        theme: "bootstrap",
        placeholder: 'Pilih salah satu',
        allowClear: true
    });
    
    let table = 
    $('#goods-table').DataTable({
        order: [[0, 'desc']], 
        processing: true,
        serverSide: true,
        ajax: "{{ url('goods') }}",   
        columns: [
            {data: 'id', render: function (data, type, row, meta) {
                return meta.row + meta.settings._iDisplayStart + 1;
            } },
            {data: 'brand_id', name: 'brand_id'},
            {data: 'name', name: 'name'},
            {data: 'type', name: 'type'},
            {data: 'volume', name: 'volume'},
            {data: 'stock', name: 'stock'},
            {data: 'min_stock', name: 'min_stock'},
            {data: 'last_purchase_price', name: 'last_purchase_price'},
            {data: 'created_at', name: 'created_at'}
        ],
        columnDefs: [{
            targets: [9],
            "render": function (data, type, row, meta) {
                return  '<div class="text-center">'+
                            '<a onclick="inflowGoods('+ row.id +')" class="btn btn-success btn-sm mx-1" data-toggle="tooltip" data-placement="bottom" title="Tambah Stok"><i class="fas fa-plus fa-2x text-white"></i></a> '+
                            '<a onclick="outflowGoods('+ row.id +')" class="btn btn-success btn-sm mx-1" data-toggle="tooltip" data-placement="bottom" title="Kurangi Stok"><i class="fas fa-minus fa-2x text-white"></i></a> '+
                            '<a onclick="editGoods('+ row.id +')" class="btn btn-info btn-sm mx-1" data-toggle="tooltip" data-placement="bottom" title="Edit Barang"><i class="fas fa-edit text-white"></i></a> ' +
                            '<a onclick="deleteGoods('+ row.id +')" class="btn btn-danger btn-sm mx-1" data-toggle="tooltip" data-placement="bottom" title="Hapus Barang"><i class="fas fa-trash text-white"></i></a>'+
                        '</div>';
            }
		}]
    });

    function addGoods() {
        save_method = "add";
        $('input[name=_method]').val('POST');
        $('#modal-form').modal('show');
        $('#modal-form form')[0].reset();
        $('.modal-title').text('Tambah Barang');
        $('#brand_id').prop("disabled", false).trigger('change').select2('val', '');
        $('#name').prop("disabled", false);
        $('#type').prop("disabled", false);
        $('#volume').prop("disabled", false).number(true, null, ',', '.');
        $('#stock').prop("disabled", false).number(true, null, ',', '.');
        $('#min_stock').prop("disabled", false).number(true, null, ',', '.');
        $('#last_purchase_price').prop("disabled", false).number(true, null, ',', '.');
    }

    function editGoods(id) {
        save_method = 'edit';
        $('input[name=_method]').val('PATCH');
        $('#modal-form form')[0].reset();
        $.ajax({
            url: "{{ url('goods') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                console.log(data);
                $('#modal-form').modal('show');
                $('.modal-title').text('Edit Barang');
                $('#id').val(data.id);
                $('#brand_id').val(data.brand_id).prop("disabled", false);
                $('#brand_id').trigger('change'); 
                $('#name').val(data.name).prop("disabled", false);
                $('#type').val(data.type).prop("disabled", false);
                $('#volume').val(data.volume).prop("disabled", false);
                $('#stock').val(data.stock).prop("disabled", true);
                $('#min_stock').val(data.min_stock).prop("disabled", false);
                $('#last_purchase_price').val(data.last_purchase_price).prop("disabled", true);
            },
            error : function(data) {
                $.each(data.errors, function(key, value){
                    $('.alert-danger').show();
                    $('.alert-danger').append('<p>'+ value +'</p>');
                });
                setTimeout(function() { 
                    $('.alert-danger').empty().hide();
                }, 5000)
            }
        });
    }

    function deleteGoods(id) {
        save_method = 'delete';
        $('input[name=_method]').val('DELETE');
        $('#modal-form form')[0].reset();
        $.ajax({
            url: "{{ url('goods') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                $('#modal-form').modal('show');
                $('.modal-title').text('Hapus Barang');
                $('#id').val(data.id);
                $('#brand_id').val(data.brand_id);
                $('#brand_id').trigger('change').prop("disabled", true);
                $('#supplier').val(data.supplier_id);
                $('#supplier').trigger('change').prop("disabled", true);  
                $('#name').val(data.name).prop("disabled", true);
                $('#type').val(data.type).prop("disabled", true);
                $('#volume').val(data.volume).prop("disabled", true);
                $('#stock').val(data.stock).prop("disabled", true);
                $('#min_stock').val(data.min_stock).prop("disabled", true);
                $('#last_purchase_price').val(data.last_purchase_price).prop("disabled", true);
            },
            error : function(data) {
                $.each(data.errors, function(key, value){
                    $('.alert-danger').show();
                    $('.alert-danger').append('<p>'+ value +'</p>');
                });
                setTimeout(function() { 
                    $('.alert-danger').empty().hide();
                }, 3000)
            }
        });
    }

    $('body').on('click', '#form-submit', function(){
        $('#form-submit').prop('disabled', true);
        $('#brand_id-error').html("");
        $('#name-error').html("");
        $('#type-error').html("");
        $('#volume-error').html("");
        $('#stock-error').html("");
        $('#min_stock-error').html("");
        $('#last_purchase_price-error').html("");
        let id = $('#id').val();

        if (save_method == 'add'){
            url = "{{ url('goods') }}";
            type = "POST";
            data = $("#modal-form form").serialize();
        }
        else if(save_method == 'edit'){
            url = "{{ url('goods') }}" + '/' + id + "/update";
            type = "POST";
            data = $("#modal-form form").serialize();
        }
        else if(save_method == 'delete'){
            url = "{{ url('goods') }}" + '/' + id + "/destroy";
            type = "POST";
            data = $("#modal-form form").serialize();
        }

        $.ajax({
            url: url,
            type: type,
            data: data,
            success:function(data) {
                console.log('sukses');
                console.log(data);
                if(data.errors) {
                    if(data.errors.brand_id){
                        $('#brand_id-error').html( data.errors.brand_id );
                    }
                    if(data.errors.name){
                        $('#name-error').html( data.errors.name );
                    }
                    if(data.errors.type){
                        $('#type-error').html( data.errors.type );
                    }
                    if(data.errors.volume){
                        $('#volume-error').html( data.errors.volume );
                    }
                    if(data.errors.stock){
                        $('#stock-error').html( data.errors.stock );
                    }
                    if(data.errors.min_stock){
                        $('#min_stock-error').html( data.errors.min_stock );
                    }
                    if(data.errors.last_purchase_price){
                        $('#last_purchase_price-error').html( data.errors.last_purchase_price );
                    }
                    $('#form-submit').prop('disabled', false);
                }
                if(data.success) {
                    $('#modal-form').modal('hide');
                    $('#form-submit').prop('disabled', false);
                    table.ajax.reload( null, false );
                    Swal.fire({
                        title: "Sukses!",
                        html:   '<p>' + data.success + '</p>',
                        type: "success",
                        timer: 2000
                    });
                }
            },
            error:function(data){
                console.log('error');
                console.log(data);
            }
        });
    });

    function inflowGoods(id) {
        save_method = "inflow";
        $('input[name=_method]').val('POST');
        $.ajax({
            url: "{{ url('goods') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                $('#flow-form').modal('show');
                $('#flow-form form')[0].reset();
                $('.modal-title').text('Tambah Stok Barang');
                $('#goods_id').val(id);
                $('.purchase-form').show();
                $('#purchase_price').prop('required', true);
                $('#quantity').prop("readonly", false);
                $('#purchase_price').number(true, null, ',', '.');
                $('#name_info').html(data.name);
                $('#stock_info').html(data.stock);
                $('#purchase_info').html(data.last_purchase_price).number(true, null, ',', '.');
            },
            error : function(data) {
                $.each(data.errors, function(key, value){
                    $('.alert-danger').show();
                    $('.alert-danger').append('<p>'+ value +'</p>');
                });
                setTimeout(function() { 
                    $('.alert-danger').empty().hide();
                }, 3000)
            }
        });
    }

    function inflowGoods(id) {
        save_method = "inflow";
        $('input[name=_method]').val('POST');
        $.ajax({
            url: "{{ url('goods') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                $('#flow-form').modal('show');
                $('#flow-form form')[0].reset();
                $('.modal-title').text('Tambah Stok Barang');
                $('#goods_id').val(id);
                $('.purchase-form').show();
                $('#purchase_price').prop('required', true);
                $('#quantity').prop("readonly", false);
                $('#purchase_price').number(true, null, ',', '.');
                $('#name_info').html(data.name);
                $('#stock_info').html(data.stock);
                $('#purchase_info').html(data.last_purchase_price).number(true, null, ',', '.');
            },
            error : function(data) {
                $.each(data.errors, function(key, value){
                    $('.alert-danger').show();
                    $('.alert-danger').append('<p>'+ value +'</p>');
                });
                setTimeout(function() { 
                    $('.alert-danger').empty().hide();
                }, 3000)
            }
        });
    }

    function outflowGoods(id) {
        save_method = "outflow";
        $('input[name=_method]').val('POST');
        $.ajax({
            url: "{{ url('goods') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                $('#flow-form').modal('show');
                $('#flow-form form')[0].reset();
                $('.modal-title').text('Kurangi Stok Barang');
                $('#goods_id').val(id);
                $('.purchase-form').hide();
                $('#purchase_price').prop('required', false);
                $('#name_info').html(data.name);
                $('#stock_info').html(data.stock);
                $('#purchase_info').html(data.last_purchase_price).number(true, null, ',', '.');
            },
            error : function(data) {
                $.each(data.errors, function(key, value){
                    $('.alert-danger').show();
                    $('.alert-danger').append('<p>'+ value +'</p>');
                });
                setTimeout(function() { 
                    $('.alert-danger').empty().hide();
                }, 3000)
            }
        });
    }

    $('body').on('click', '#flow-submit', function(){
        $('#flow-submit').prop('disabled', true);
        $('#quantity-error').html("");
        $('#detail-error').html("");
        $('#purchase_price-error').html("");
        let id = $('#id').val();

        if (save_method == 'inflow'){
            url = "{{ url('inflow/store') }}";
            type = "POST";
            data = $("#flow-form form").serialize();
            console.log(data);
        } 
        else if (save_method == 'outflow'){
            url = "{{ url('outflow/store') }}";
            type = "POST";
            data = $("#flow-form form").serialize();
        } 

        $.ajax({
            url: url,
            type: type,
            data: data,
            success:function(data) {
                console.log('sukses');
                console.log(data);
                if(data.errors) {
                    if(data.errors.quantity){
                        $('#quantity-error').html( data.errors.quantity );
                    }
                    if(data.errors.detail){
                        $('#detail-error').html( data.errors.detail );
                    }
                    if(data.errors.purchase_price){
                        $('#purchase_price-error').html( data.errors.purchase_price );
                    }
                    $('#flow-submit').prop('disabled', false);
                }
                if(data.success) {
                    $('#flow-form').modal('hide');
                    $('#flow-submit').prop('disabled', false);
                    table.ajax.reload( null, false );
                    Swal.fire({
                        title: "Sukses!",
                        html:   '<p>' + data.success + '</p>',
                        type: "success",
                        timer: 2000
                    });
                }
            },
            error:function(data){
                console.log('error');
                console.log(data);
            }
        });
    });
</script>

{% endblock %}