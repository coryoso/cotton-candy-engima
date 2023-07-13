from math import sqrt
from typing import List
from fastapi import FastAPI
from pydantic import BaseModel
from typing import List
from gpiozero import Motor

from functions import segmentToMotorForward

app = FastAPI()

motor = Motor(17, 18)


@app.get("/")
async def root():
    return {"message": "Reachable"}


class Point(BaseModel):
    x: float
    y: float

    def distance_to(self, other_point):
        dx = self.x - other_point.x
        dy = self.y - other_point.y
        distance = sqrt(dx**2 + dy**2)
        return distance


class Segment(BaseModel):
    start: Point
    end: Point


class Path(BaseModel):
    segments: List[Segment]


@app.post("/path")
async def path(path: Path):
    for segment in path.segments:
        # calculate the length of the segment
        length = segment.start.distance_to(segment.end)

        # move the motor forward
        for _ in range(int(length)):
            motor.forward(1)

    return {"message": "Received command"}
