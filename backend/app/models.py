from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Entrega(Base):
    __tablename__ = "entregas"
    id = Column(Integer, primary_key=True, index=True)
    producto = Column(String)
    cantidad = Column(Integer)
    fecha_entrega = Column(String)
    fecha_caducidad = Column(String)
    cliente_nombre = Column(String)

class Pago(Base):
    __tablename__ = "pagos"
    id = Column(Integer, primary_key=True, index=True)
    cliente_nombre = Column(String)
    cantidad_pagada = Column(Integer)
    fecha_pago = Column(String)
