{% extends '../layouts/app.volt' %}

{% block content %}
<div class="d-flex justify-content-between">
    <h1 class="h3 mb-2 text-gray-800">Daftar Pemasukan Barang</h1>
</div>
<hr>
<div class="card shadow mb-4">
    <div class="card-body">
        <div class="table-responsive">
            <div class="row input-daterange">
                <div class="col-md-4">
                    <input type="text" name="from_date" id="from_date" class="form-control" placeholder="From Date" readonly />
                </div>
                <div class="col-md-4">
                    <input type="text" name="to_date" id="to_date" class="form-control" placeholder="To Date" readonly />
                </div>
                <div class="col-md-4">
                    <button type="button" name="refresh" id="refresh" class="btn btn-secondary">Refresh</button>
                    <button type="button" name="filter" id="filter" class="btn btn-primary">Filter</button>
                </div>
            </div>
            <hr>
            <table class="table table-bordered" id="inflow-table" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>User</th>
                        <th>Barang</th>
                        <th>Jumlah</th>
                        <th>Stok Sekarang</th>
                        <th>Keterangan</th>
                        <th>Tanggal</th>
                        <th>Harga Beli</th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>
        </div>
    </div>
</div>

{% endblock %}

{% block js %}

<script type="text/javascript">
    $(document).ready(function(){
        $('.input-daterange').datepicker({
            todayBtn: 'linked',
            format: 'yyyy-mm-dd',
            autoclose: true
        });

        load_data();

        function load_data(from_date = '', to_date = ''){
            console.log(from_date);
            console.log(to_date);
            $('#inflow-table').DataTable({
                processing: true,
                serverSide: true,
                order: [[0, 'desc']],
                ajax: {
                    url:"{{ url('inflow') }}",
                    method:"POST",
                    data:{from_date:from_date, to_date:to_date}
                },
                columns: [
                    {data: 'id', render: function (data, type, row, meta) {
                        return meta.row + meta.settings._iDisplayStart + 1;
                    } },
                    {data: 'user_id', name: 'user_id'},
                    {data: 'name', name: 'name'},
                    {data: 'quantity', name: 'quantity'},
                    {data: 'cur_stock', name: 'cur_stock'},
                    {data: 'detail', name: 'detail'},
                    {data: 'updated_at', name: 'updated_at'},
                    {data: 'purchase_price', name: 'purchase_price'}
                ]
            });
        }

        $('#filter').click(function(){
            let from_date = $('#from_date').val();
            let to_date = $('#to_date').val();
            if(from_date != '' &&  to_date != ''){
                $('#inflow-table').DataTable().destroy();
                load_data(from_date, to_date);
            }else{
                alert('Both Date is required');
            }
        });

        $('#refresh').click(function(){
            $('#from_date').val('');
            $('#to_date').val('');
            $('#inflow-table').DataTable().destroy();
            load_data();
        });

    });
</script>

{% endblock %}