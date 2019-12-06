        <ul class="navbar-nav primer sidebar accordion" id="accordionSidebar">
    
            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">
                <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-magic"></i>
                </div>
                <div class="sidebar-brand-text mx-3">Stock-Man</div>
            </a>
    
            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

            <!-- Heading -->
            <div class="sidebar-heading">
                Pengaturan Produk
            </div>
            
            <!-- Nav Item - Utilities Collapse Menu -->
            
            <li class="nav-item">
                <a class="nav-link" href="{{url('goods')}}">
                <i class="fas fa-cubes"></i>
                <span>Stok Saya</span></a>
            </li>
        
            <li class="nav-item">
                <a class="nav-link" href="{{url('recommend')}}">
                <i class="fas fa-search-dollar"></i>
                <span>Perhitungan Harga</span></a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="{{url('brand')}}">
                <i class="fas fa-clipboard-list"></i>
                <span>Manajemen Merk</span></a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="{{url('inflow')}}">
                <i class="fas fa-history"></i>
                <span>Histori Pemasukan Stok</span></a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="{{url('outflow')}}">
                <i class="fas fa-history"></i>
                <span>Histori Pengeluaran Stok</span></a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="{{url('filter/minimal')}}">
                <i class="fas fa-cart-plus"></i>
                <span>Stok Menipis</span></a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="{{url('filter/empty')}}">
                <i class="fas fa-cart-plus"></i>
                <span>Stok Habis</span></a>
            </li>
        </ul>