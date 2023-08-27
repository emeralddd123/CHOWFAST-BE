import authRouter from "./auth";
import userRouter from "./user";

export default function routes(app, express, redisClient) {
  app.use("/api/v1/login", authRouter(express, redisClient));
  app.use("/api/v1/users", userRouter(express, redisClient));
}
