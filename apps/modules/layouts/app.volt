<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Stock-Man</title>

    <link href="{{ url('sb-admin2/vendor/fontawesome-free/css/all.min.css') }}" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <link href="{{ url('sb-admin2/css/sb-admin-2.min.css') }}" rel="stylesheet">
    <link href="{{ url('sb-admin2/vendor/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet">
    <link href="{{ url('icon/material-icons.css') }}" rel="stylesheet">
    <link href="{{ url('css/select2.min.css') }}" rel="stylesheet">
    <link href="{{ url('css/select2-bootstrap.min.css') }}" rel="stylesheet">
    <link href="{{ url('css/sweetalert2.min.css') }}" rel="stylesheet">

    {% block css%}
    {% endblock %}
</head>
<body id="page-top">
    <div id="wrapper">
        <!-- Sidebar -->
            {% include '../layouts/sidebar.volt' %}
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column" style="background-color: #fff5f6;">
            <!-- Main Content -->
            <div id="content">
                <!-- Topbar -->
                    {% include '../layouts/topbar.volt' %}
                <!-- End of Topbar -->
                <!-- Begin Page Content -->
                <div class="container-fluid">
                    {% block content%}
                    {% endblock %}
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
            <!-- Footer -->
                {% include '../layouts/footer.volt' %}
            <!-- End of Footer -->
        </div>
        <!-- End of Content Wrapper -->

    </div>


    <!-- Bootstrap core JavaScript-->
    <script src="{{ url('sb-admin2/vendor/jquery/jquery.min.js') }}"></script>
    <script src="{{ url('sb-admin2/vendor/bootstrap/js/bootstrap.bundle.min.js') }}"></script>

    <!-- Core plugin JavaScript-->
    <script src="{{ url('sb-admin2/vendor/jquery-easing/jquery.easing.min.js') }}"></script>

    <!-- Custom scripts for all pages-->
    <script src="{{ url('sb-admin2/js/sb-admin-2.min.js') }}"></script>

    <!-- Page level plugins -->
    <script src="{{ url('sb-admin2/vendor/datatables/jquery.dataTables.min.js') }}"></script>
    <script src="{{ url('sb-admin2/vendor/datatables/dataTables.bootstrap4.min.js') }}"></script>
    <script src="{{ url('js/select2.min.js') }}"></script>
    <script src="{{ url('js/sweetalert2.min.js') }}"></script>
    <script src="{{ url('js/jquery.number.min.js') }}"></script>
    
    {% block js%}
    {% endblock %}
</body>
</html>
