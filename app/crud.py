from .models import Entrega, Pago
from sqlalchemy.orm import Session

def registrar_entrega(db: Session, producto: str, cantidad: int, entrega: str, caducidad: str, cliente: str):
    e = Entrega(producto=producto, cantidad=cantidad, fecha_entrega=entrega, fecha_caducidad=caducidad, cliente_nombre=cliente)
    db.add(e)
    db.commit()
    db.refresh(e)
    return e

def registrar_pago(db: Session, cantidad: int, fecha: str, cliente: str):
    p = Pago(cliente_nombre=cliente, cantidad_pagada=cantidad, fecha_pago=fecha)
    db.add(p)
    db.commit()
    db.refresh(p)
    return p

def calcular_saldo(db: Session, cliente: str):
    entregas = db.query(Entrega).filter(Entrega.cliente_nombre == cliente).all()
    pagos = db.query(Pago).filter(Pago.cliente_nombre == cliente).all()
    total_entregado = sum(e.cantidad for e in entregas)
    total_pagado = sum(p.cantidad_pagada for p in pagos)
    return {"cliente": cliente, "total_entregado": total_entregado, "total_pagado": total_pagado, "saldo": total_entregado - total_pagado}

def inventario_por_cliente(db: Session, cliente: str):
    entregas = db.query(Entrega).filter(Entrega.cliente_nombre == cliente).all()
    inventario = {}
    for e in entregas:
        inventario[e.producto] = inventario.get(e.producto, 0) + e.cantidad
    return inventario

def registrar_entregas_masivo(db: Session, datos: list):
    resultados = []
    for fila in datos:
        entrega = registrar_entrega(db, fila["producto"], fila["cantidad"], fila["fecha_entrega"], fila["fecha_caducidad"], fila["cliente"])
        resultados.append(entrega)
    return resultados
