document.addEventListener("DOMContentLoaded", function () {
    const isAuthenticated = localStorage.getItem('auth') === 'true';
    const currentPath = window.location.pathname;
    const currentPage = currentPath.split('/').pop().toLowerCase();

    // Rutas permitidas sin login
    const isLoginPath = currentPath.includes('/credenciales/');
    const publicPages = ['login.html', 'registro.html'];

    if (!isAuthenticated && (!isLoginPath || !publicPages.includes(currentPage))) {
        window.location.href = "../credenciales/login.html"; // subir desde /menu
    }
});

// Iniciar sesión desde login.html
function iniciarSesion(usuario, clave) {
    if (usuario === 'admin' && clave === 'admin') {
        localStorage.setItem('auth', 'true');
        localStorage.setItem('usuario', usuario);
        window.location.href = "../menu/inventario.html"; // ir al panel principal
    } else {
        alert("Usuario o contraseña incorrectos");
    }
}

function cerrarSesion() {
    localStorage.removeItem('auth');
    localStorage.removeItem('usuario');
    window.location.href = "../credenciales/login.html";
}