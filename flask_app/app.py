from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.exc import IntegrityError

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:12345678@localhost/postgres'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Survey(db.Model):
    __tablename__ = 'test2'  
    id = db.Column(db.BigInteger, primary_key=True, autoincrement=True)  
    name = db.Column(db.String(150))
    children_home_needs = db.Column(db.Text, nullable=False)
    clothing_need = db.Column(db.Integer, nullable=False)
    stationery_need = db.Column(db.Integer, nullable=False)
    hygiene_need = db.Column(db.Integer, nullable=False)
    toys_need = db.Column(db.Integer, nullable=False)
    textbooks_need = db.Column(db.Integer, nullable=False)


@app.route('/submit', methods=['POST'])
def submit_survey():
    data = request.json
    try:
        new_survey = Survey(
            name=data.get('name'),  
            children_home_needs=data['children_home'],
            clothing_need=data['clothing'],
            stationery_need=data['stationery'],
            hygiene_need=data['hygiene'],
            toys_need=data['toys'],
            textbooks_need=data['textbooks']
        )
        db.session.add(new_survey)
        db.session.commit()
        return jsonify({"message": "Survey submitted successfully!"}), 201
    except IntegrityError as e:
        db.session.rollback()
        return jsonify({"message": "Error submitting survey", "error": str(e)}), 400
    except KeyError as e:
        db.session.rollback()
        return jsonify({"message": f"Missing key in request data: {str(e)}"}), 400

if __name__ == '__main__':
    app.run(debug=True)
