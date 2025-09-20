import mongoose from "mongoose";

const playerSchema = new mongoose.Schema({
    name:{
        type:String,
        require:true
    },
    email:{
        type:String,
        require:true
    },
    password:{
        type:String,
        require:true
    },
    sport:{
        type:String,
    },
    token:{
        type:String,
        require:true
    },
    coach: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Coach",
    }
});


export default mongoose.model("Player", playerSchema);

