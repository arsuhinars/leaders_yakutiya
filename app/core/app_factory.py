from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core import db
from app.core.settings import settings


@asynccontextmanager
async def lifespan(app: FastAPI):
    db.initialize()

    yield

    db.release()


def create_app():
    app = FastAPI(redoc_url=None, title="FSP Cup 2023", lifespan=lifespan)

    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.allow_origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    return app
