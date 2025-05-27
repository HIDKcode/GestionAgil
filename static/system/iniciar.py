from flask import Flask, jsonify, request
import sqlite3

app = Flask(__name__)

def conectar_db():
    return sqlite3.connect('mi_base_de_datos.db')

@app.route('/usuarios', methods=['GET'])
def listar_usuarios():
    conn = conectar_db()
    cursor = conn.cursor()
    cursor.execute('SELECT id, usuario, rol FROM usuarios')
    usuarios = cursor.fetchall()
    conn.close()
    return jsonify([{'id': u[0], 'usuario': u[1], 'rol': u[2]} for u in usuarios])

@app.route('/usuarios', methods=['POST'])
def crear_usuario():
    data = request.json
    conn = conectar_db()
    cursor = conn.cursor()
    try:
        cursor.execute('INSERT INTO usuarios (usuario, clave, rol) VALUES (?, ?, ?)', 
                       (data['usuario'], data['clave'], data['rol']))
        conn.commit()
        return jsonify({'mensaje': 'Usuario creado'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 400
    finally:
        conn.close()

if __name__ == '__main__':
    app.run(port=5000)  