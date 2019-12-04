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
            $('#purchase_info').html(data.last_purchase_price);
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
            $('#purchase_info').html(data.last_purchase_price);
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
        console.log(data);
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