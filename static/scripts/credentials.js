document.addEventListener("DOMContentLoaded", function () {
    const isAuthenticated = localStorage.getItem('auth') === 'true';
    const userRole = localStorage.getItem('rol');
    const currentPath = window.location.pathname;
    const currentPage = currentPath.split('/').pop().toLowerCase();

    const isLoginPage = currentPath.includes('/credenciales/login.html');

    // Páginas públicas sin protección
    const publicPages = ['login.html'];

    if (!isAuthenticated && !publicPages.includes(currentPage)) {
        window.location.href = "/vistas/credenciales/login.html";
        return;
    }

    // Protege admin.html solo para administradores
    if (currentPage === 'admin.html' && userRole !== 'admin') {
        alert("Acceso denegado: solo administradores");
        window.location.href = "/vistas/menu/inventario.html"; // o cualquier otra vista válida
        return;
    }
});

// Función de login (llamada desde login.html)
function iniciarSesion(usuario, clave) {
    let rol = '';
    if (usuario === 'admin' && clave === 'admin') {
        rol = 'admin';
    } else if (usuario === 'trabajador' && clave === 'trabajador') {
        rol = 'trabajador';
    } else {
        alert("Credenciales inválidas");
        return;
    }

    localStorage.setItem('auth', 'true');
    localStorage.setItem('usuario', usuario);
    localStorage.setItem('rol', rol);

    window.location.href = "/vistas/menu/inventario.html"; // Vista de entrada general
}

// Cerrar sesión
function cerrarSesion() {
    localStorage.clear();
    window.location.href = "/vistas/credenciales/login.html";
}
