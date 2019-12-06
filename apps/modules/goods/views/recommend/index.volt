{% extends '../layouts/app.volt' %}

{% block css %}

<style>
    .table > thead > tr > td {
            vertical-align: middle;
            text-align: center;
    }
</style>

{% endblock %}

{% block content %}
<div class="d-flex justify-content-between">
    <h1 class="h3 mb-2 text-gray-800">Daftar Rekomendasi Harga</h1>
</div>
<hr>
                        
<div class="card shadow mb-4">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="recom-table" cellspacing="0" width="100%">
                <div class="alert alert-danger" style="display:none"></div>
                <div class="alert alert-success" style="display:none"></div>
                {{ flashSession.output() }}
                <thead>
                    <tr>
                        <td rowspan="2">No</td>
                        <td rowspan="2">Barang</td>
                        <td rowspan="2">Jenis</td>
                        <td rowspan="2" widtd="6rem">Harga Beli</td>
                        <td rowspan="2">Varian(ml)</td>
                        <td class="text-white bg-info" colspan="2">Normal</td>
                        <td rowspan="2">Harga Pasar</td>
                        <td rowspan="2">Harga Rekomendasi</td>
                        <td rowspan="2">Keuntungan</td>
                        <td class="text-white bg-success" colspan="2">Akhir</td>
                        <td rowspan="2" width="6rem">Aksi</td>
                    </tr>
                    <tr>
                        <td>Keuntungan</td>
                        <td>Harga Jual</td>
                        <td>Keuntungan</td>
                        <td>Harga</td>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>

{% include '/views/recommend/inc/form.volt' %}
{% include '/views/recommend/inc/confirm.volt' %}

{% endblock %}

{% block js %}
<script type="text/javascript">
    $('[data-toggle="tooltip"]').tooltip();
    
    let table =
    $('#recom-table').DataTable({
        processing: true,
        serverSide: true,
        order: [[0, 'desc']],
        ajax: {
            url: "{{ url('recommend') }}"
        },
        columns: [
            {data: 'gid', render: function (data, type, row, meta) {
                return meta.row + meta.settings._iDisplayStart + 1;
            } },
            {data: 'name, volume', name: 'name', render: function (data, type, row, meta) {
                return row.name + ' (' + row.volume + ' ml)' +
                    '<div class="dropdown">'+
                        '<button type="button" class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown">Tindakan</button>'+
                        '<ul class="dropdown-menu px-2">'+
                            '<li onclick="addRecom('+ row.gid +')" class="dropdown-item bg-success my-1 text-white" style="cursor: pointer"><a class="">Tambah Perhitungan</a></li>'+
                            '<li onclick="refreshRecom('+ row.gid +')" class="dropdown-item bg-info my-1 text-white" style="cursor: pointer"><a class="">Perbarui Perhitungan</a></li>'+
                        '</ul>'+
                    '</div>';
            } },
            {data: 'type', name: 'type'},
            {data: 'last_purchase_price', name: 'last_purchase_price'},
            {data: 'variant', name: 'variant', orderable: false},
            {data: 'normal_profit', name: 'normal_profit', orderable: false},
            {data: 'normal_price', name: 'normal_price', orderable: false},
            {data: 'market_price', name: 'market_price', orderable: false},
            {data: 'recommend_price', name: 'recommend_price', orderable: false},
            {data: 'profit', name: 'profit', orderable: false},
            {data: 'last_profit', name: 'last_profit', orderable: false},
            {data: 'last_price', name: 'last_price', orderable: false},
            {data: 'rid', name: 'rid', orderable: false,
                render: function (data, type, row, meta) {
                    if(row.rid){
                        return '<div class="d-flex justify-content-between">'+
                                    '<a onclick="editRecom('+ row.rid +')" style="cursor:pointer" class="text-white mx-2 px-2 bg-info">Edit</a>'+
                                    '<a onclick="deleteRecom('+ row.rid +')" style="cursor:pointer" class="text-white mx-2 px-2 bg-danger">Hapus</a>'+
                                '</div>';
                    }else {
                        return '';
                    }
                }
            }
        ]
    });


    function addRecom(id) {
        save_method = 'add';
        $('#modal-form form')[0].reset();
        $.ajax({
            url: "{{ url('goods') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                console.log(data);
                $('#modal-form').modal('show');
                $('.modal-title').text('Tambah Rekomendasi Harga');
                $('#goods_id').val(data.id);
                $('#name_info').html(data.name);
                $('#purchase_info').html(data.last_purchase_price).number(true, null, ',', '.');
                $('#volume_info').html(data.volume);
                $('#variant').number(true, null, ',', '.');
                $('#package').number(true, null, ',', '.');
                $('#market_price').number(true, null, ',', '.');
                $('#last_price').number(true, null, ',', '.');
                let price = parseInt(data.last_purchase_price);
                let volume = parseInt(data.volume);
                $('.form-group').on('input paste', function(){
                    let modal = price *  parseInt( $('#variant').val() ) / volume;
                    $('#modal').val(modal).number(true, null, ',', '.');

                    let hpp = parseInt( modal ) + parseInt( $('#package').val() );
                    $('#hpp').val(hpp).number(true, null, ',', '.');

                    let normal_profit = parseInt( 0.3 * hpp );
                    $('#normal_profit').val(normal_profit).number(true, null, ',', '.');

                    let normal_price = parseInt( modal ) + parseInt( normal_profit ) + parseInt( $('#package').val() );
                    $('#normal_price').val(normal_price).number(true, null, ',', '.');

                    let recommend_price = 0.0;
                    if(parseInt( normal_price ) < parseInt( $('#market_price').val() )){
                        recommend_price = parseInt( $('#market_price').val() ) - 1000;
                    }else if(parseInt( normal_price ) > parseInt( $('#market_price').val() )){
                        recommend_price = parseInt( $('#market_price').val() );
                    }
                    $('#recommend_price').val(recommend_price).number(true, null, ',', '.');

                    let profit = parseInt( recommend_price ) - parseInt( hpp );
                    $('#profit').val(profit).number(true, null, ',', '.');

                    let last_profit = parseInt( $('#last_price').val() ) - parseInt( hpp );
                    $('#last_profit').val(last_profit).number(true, null, ',', '.');
                });
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

    function editRecom(id) {
        save_method = 'edit';
        $('#modal-form form')[0].reset();
        $.ajax({
            url: "{{ url('recommend') }}" + '/' + id + "/edit",
            type: "GET",
            dataType: "JSON",
            success: function(data) {
                console.log(data);
                $('#modal-form').modal('show');
                $('.modal-title').text('Edit Rekomendasi Harga');
                $('#id').val(data.id);
                $('#goods_id').val(data.goods_id);
                $('#name_info').html(data.name);
                $('#purchase_info').html(data.last_purchase_price).number(true, null, ',', '.');
                $('#volume_info').html(data.volume).number(true, null, ',', '.');
                let price = parseFloat(data.last_purchase_price);
                let volume = parseFloat(data.volume);
                $('#variant').val(data.variant); 
                $('#modal').val(data.modal); 
                $('#package').val(data.package); 
                $('#hpp').val(data.hpp); 
                $('#normal_profit').val(data.normal_profit);
                $('#normal_price').val(data.normal_price);
                $('#market_price').val(data.market_price);
                $('#recommend_price').val(data.recommend_price);
                $('#profit').val(data.profit);
                $('#last_price').val(data.last_price);
                $('#last_profit').val(data.last_profit);
                $('.form-group').on('input change paste', function(){
                    let modal = price *  parseFloat( $('#variant').val() ) / volume;
                    $('#modal').val(modal).number(true, null, ',', '.');

                    let hpp = parseFloat( modal ) + parseFloat( $('#package').val() );
                    $('#hpp').val(hpp).number(true, null, ',', '.');

                    let normal_profit = parseFloat( 0.3 * modal );
                    $('#normal_profit').val(normal_profit).number(true, null, ',', '.');

                    let normal_price = parseFloat( modal ) + parseFloat( normal_profit ) + parseFloat( $('#package').val() );
                    $('#normal_price').val(normal_price).number(true, null, ',', '.');

                    let recommend_price = 0.0;
                    if(parseFloat( normal_price ) < parseFloat( $('#market_price').val() )){
                        recommend_price = parseFloat( $('#market_price').val() ) - 1000;
                    }else if(parseFloat( normal_price ) > parseFloat( $('#market_price').val() )){
                        recommend_price = parseFloat( $('#market_price').val() );
                    }
                    $('#recommend_price').val(recommend_price).number(true, null, ',', '.');

                    let profit = parseFloat( recommend_price ) - parseFloat( hpp );
                    $('#profit').val(profit).number(true, null, ',', '.');

                    let last_profit = parseFloat( $('#last_price').val() ) - parseFloat( hpp );
                    $('#last_profit').val(last_profit).number(true, null, ',', '.');
                });
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
    $('body').on('click', '#form-submit', function(){
        $('#form-submit').prop('disabled', true);
        $('#variant-error').html("");
        $('#package-error').html("");
        $('#market_price-error').html("");
        $('#last_price-error').html("");
        let id = $('#id').val();
        if (save_method == 'add'){
            url = "{{ url('recommend') }}" + "/store";
            type = "POST";
            data = $("#modal-form form").serialize();
        } 
        else if(save_method == 'edit'){
            url = "{{ url('recommend') }}" + '/' + id + "/update";
            type = "POST";
            data = $("#modal-form form").serialize();
        }
        console.log(url);
        $.ajax({
            url : url,
            type : type,
            data: data,
            success : function(data) {
                console.log('sukses');
                console.log(data);
                if(data.errors) {
                    if(data.errors.variant){
                        $('#variant-error').html( data.errors.variant );
                    }
                    if(data.errors.package){
                        $('#package-error').html( data.errors.package );
                    }
                    if(data.errors.market_price){
                        $('#market_price-error').html( data.errors.market_price );
                    }
                    if(data.errors.last_price){
                        $('#last_price-error').html( data.errors.last_price );
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
            error : function(data){
                console.log('error');
                console.log(data);
            }
        });
    });

    function deleteRecom(id) {
        save_method = 'delete';
        $('#confirm-form').modal('show');
        $('.modal-title').text('Hapus Rekomendasi Harga');
        $('#id_recom').val(id);
    }

    function refreshRecom(id) {
        save_method = 'refresh';
        $('#confirm-form').modal('show');
        $('.modal-title').text('Perbarui Rekomendasi Harga');
        $('#id_recom').val(id);
    }

    
    $('body').on('click', '#confirm-submit', function(){
        $('#confirm-submit').prop('disabled', true);
        let id = $('#id_recom').val();
        let csrf_token = $('meta[name="csrf-token"]').attr('content');
        console.log(save_method);
        if(save_method == 'delete'){
            url = "{{ url('recommend') }}" + '/' + id + "/destroy";
            type = "POST";
            data = $("#confirm-form form").serialize();
        }
        else if(save_method == 'refresh'){
            url = "{{ url('recommend') }}" + '/' + id + "/refresh";
            type = "POST";
            data = $("#confirm-form form").serialize();
        }
        $.ajax({
            url : url,
            type : type,
            data: data,
            success : function(data) {
                $('#confirm-form').modal('hide');
                $('#confirm-submit').prop('disabled', false);
                table.ajax.reload( null, false );
                Swal.fire({
                    title: "Sukses!",
                    html:   '<p>' + data.success + '</p>',
                    type: "success",
                    timer: 2000
                });
            },
            error : function(data){
                $('#confirm-submit').prop('disabled', false);
                $.each(data.errors, function(key, value){
                    $('.alert-danger').show();
                    $('.alert-danger').append('<p>'+value+'</p>');
                });
                setTimeout(function() { 
                    $('.alert-danger').empty().hide();
                }, 5000)
            }
        });
    });
    
</script>
{% endblock %}

