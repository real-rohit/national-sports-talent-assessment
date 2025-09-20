import express from "express";
import 'dotenv/config'
import connectDB from "./config/db.js";
import Player from "./models/player.js";
import Coach from "./models/coach.js";
import jwt from "jsonwebtoken";
import cookieParser from "cookie-parser";
import bcrypt from "bcrypt";

const app = express();
const port = process.env.PORT;

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

async function hashPass(password){
    return await bcrypt.hash(password,10);
}

async function comparePasswords(userPass, hashedPass){
    return await bcrypt.compare(userPass, hashedPass);
}

connectDB();

app.get("/", (req, res) => {
    const token = req.cookies.jwt;
    if(token){
        try {
            const verify = jwt.verify(token, "qwertyuiopasdfghjklzxcvbnm123456789");
            res.json({ message: { name: verify.name } });
        } catch {
            res.json({ message: "Invalid Token" });
        }
    } else {
        res.json({ message: "Please login" });
    }
});

app.post("/player/signup", async(req, res) => {
    try{
        const check = await Player.findOne({ email: req.body.email });
        if(check){
            return res.json({ message: "Player Already Exist" });
        }

        const token = jwt.sign({ name: req.body.name }, "qwertyuiopasdfghjklzxcvbnm123456789");
        const data = {
            name: req.body.name,
            email: req.body.email,
            password: await hashPass(req.body.password),
            sport: req.body.sport,
            token: token
        };

        await Player.insertMany([data]);
        res.cookie("jwt", token, { maxAge: 6000000, httpOnly: true });
        res.json({ message: "Player Signup Successfully" });
    } catch(error){
        console.error(error);
        res.json({ message: "Error", error: error.message });
    }
});

app.post("/player/login", async(req, res) => {
    try{
        const player = await Player.findOne({ email: req.body.email });
        if(!player) return res.json({ message: "Player Not Found" });

        const passCheck = await comparePasswords(req.body.password, player.password);
        if(passCheck){
            res.cookie("jwt", player.token, { maxAge: 6000000, httpOnly: true });
            res.json({ message: "Player Login Successfully" });
        } else {
            res.json({ message: "Wrong Password" });
        }
    } catch(error){
        console.error(error);
        res.json({ message: "Error", error: error.message });
    }
});

app.post("/coach/signup", async(req, res) => {
    try{
        const check = await Coach.findOne({ email: req.body.email });
        if(check){
            return res.json({ message: "Coach Already Exist" });
        }

        const token = jwt.sign({ name: req.body.name }, "qwertyuiopasdfghjklzxcvbnm123456789");
        const data = {
            name: req.body.name,
            email: req.body.email,
            password: await hashPass(req.body.password),
            sport: req.body.sport,
            token: token
        };

        await Coach.insertMany([data]);
        res.cookie("jwt", token, { maxAge: 6000000, httpOnly: true });
        res.json({ message: "Coach Signup Successfully" });
    } catch(error){
        console.error(error);
        res.json({ message: "Error", error: error.message });
    }
});

app.post("/coach/login", async(req, res) => {
    try{
        const coach = await Coach.findOne({ email: req.body.email });
        if(!coach) return res.json({ message: "Coach Not Found" });

        const passCheck = await comparePasswords(req.body.password, coach.password);
        if(passCheck){
            res.cookie("jwt", coach.token, { maxAge: 6000000, httpOnly: true });
            res.json({ message: "Coach Login Successfully" });
        } else {
            res.json({ message: "Wrong Password" });
        }
    } catch(error){
        console.error(error);
        res.json({ message: "Error", error: error.message });
    }
});

app.listen(port, () => {
    console.log(`Server is running on port: ${port}`);
});
