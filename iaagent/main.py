from fastapi import FastAPI

app = FastAPI(title="EntreGA IA Agent", version="1.0.0")

@app.get("/")
def home():
    return {"status": "ok", "msg": "FastAPI agent online"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
