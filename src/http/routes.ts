import { Router } from "express";
import { healthcheckeAws } from "./controller/healthcheckAws";



const routes = Router();

routes.get("/", healthcheckeAws);


export { routes };