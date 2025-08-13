#!/usr/bin/env python3
"""
Script de prueba para la API del webhook simulado
"""

import requests
import json

# URL base de la API
BASE_URL = "http://localhost:8000"

def test_webhook():
    """Prueba el endpoint del webhook"""
    
    # Datos de prueba
    test_data = {
        "numero": "+1234567890",
        "nombre": "Juan Pérez",
        "mensaje": "Hola, ¿cómo estás?"
    }
    
    try:
        # Enviar POST request
        response = requests.post(
            f"{BASE_URL}/webhook/simulado",
            json=test_data,
            headers={"Content-Type": "application/json"}
        )
        
        print(f"Status Code: {response.status_code}")
        print(f"Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")
        
        if response.status_code == 200:
            print("✅ Webhook funcionando correctamente")
        else:
            print("❌ Error en el webhook")
            
    except requests.exceptions.ConnectionError:
        print("❌ No se puede conectar a la API. Asegúrate de que esté ejecutándose en http://localhost:8000")
    except Exception as e:
        print(f"❌ Error: {e}")

def test_docs():
    """Prueba si la documentación está disponible"""
    try:
        response = requests.get(f"{BASE_URL}/docs")
        if response.status_code == 200:
            print("✅ Documentación disponible en http://localhost:8000/docs")
        else:
            print("❌ Documentación no disponible")
    except:
        print("❌ No se puede acceder a la documentación")

if __name__ == "__main__":
    print("🧪 Probando API del webhook simulado...\n")
    
    print("1. Probando endpoint del webhook:")
    test_webhook()
    
    print("\n2. Verificando documentación:")
    test_docs()
    
    print("\n📚 Para más información, consulta el README.md")
