import mongoose from "mongoose";

const coachSchema = new mongoose.Schema({
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
    }
});

export default mongoose.model("Coach", coachSchema);
