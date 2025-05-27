import sqlite3

def ejecutar_script_sql(nombre_archivo, conexion):
    with open(nombre_archivo, 'r', encoding='utf-8') as archivo:
        sql_script = archivo.read()
    cursor = conexion.cursor()
    cursor.executescript(sql_script)
    conexion.commit()

def main():
    conn = sqlite3.connect('mi_base_de_datos.db')
    try:
        print("Eliminando tablas...")
        ejecutar_script_sql('deletetables.sql', conn)

        print("Creando tablas...")
        ejecutar_script_sql('createtables.sql', conn)

        print("Insertando datos iniciales...")
        ejecutar_script_sql('inserttables.sql', conn)

        print("¡Base de datos lista!")
    except Exception as e:
        print("Error:", e)
    finally:
        conn.close()

if __name__ == '__main__':
    main()