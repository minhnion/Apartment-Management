from api.admin import admin_bp
from flask import jsonify, request, current_app, redirect, url_for
from api.models.models import *
from dotenv import load_dotenv
from helpers import getIP
from datetime import datetime, timedelta
from functools import wraps
from api.admin import admin_bp

from api.extensions import db

import jwt


load_dotenv()

@admin_bp.route('/')
def index():
    return "ADMIN INDEX VIEW" 

@admin_bp.get('/<house_id>/resident')
def get_resident(house_id):
    house_hold = Households.query.filter(house_id == house_id).first()
    result = jsonify({
        "house_id": house_id,
        "household_name": house_hold.household_name,
        "apartment_number": house_hold.apartment_number,
        "floor": house_hold.floor,
        "area": house_hold.area,
        "phone_number": house_hold.phone_number,
        "num_residents": house_hold.num_residents,
        "managed_by": house_hold.managed_by
    })
    return result   

@admin_bp.route('/fee/<int:household_id>')
def fee(household_id):
    
    service_rate = db.session.query(Fees.service_rate).filter_by(household_id=household_id).scalar() or None
    manage_rate = db.session.query(Fees.manage_rate).filter_by(household_id=household_id).scalar() or None
    area = db.session.query(Households.area).filter_by(household_id=household_id).scalar() or None

    if not service_rate or not manage_rate or not area:
        return jsonify({"message" : "cannot query from db"}), 404

    service_charge = service_rate*float(area)
    manage_charge = manage_rate*float(area)
    amount = (service_rate + manage_rate)*float(area)

    result = jsonify(
        {
            'service_charge': f'{service_charge}', 
            'manage_charge' : f'{manage_charge}', 
            'fee' : f'{amount}'
        }
    )

    return result, 200

@admin_bp.route('/not-pay')
def not_pay():
    
    household_ids = db.session.query(Fees.household_id).filter_by(status = 'Chưa thanh toán').all()
    res = []
    household_ids = sorted(household_ids)
    for household_id in household_ids:
        # get household_id
        household_id = household_id[0]
        service_rate = db.session.query(Fees.service_rate).filter_by(household_id=household_id).scalar() or 0
        manage_rate = db.session.query(Fees.manage_rate).filter_by(household_id=household_id).scalar() or 0
        area = db.session.query(Households.area).filter_by(household_id=household_id).scalar() or 0
        amount = (service_rate + manage_rate)*float(area)

        infor = {
                'room_number': f'{household_id}',
                'fee' : f'{amount}'
            }

        res.append(infor)

    result = jsonify(res)
    
    return result, 200

@admin_bp.route('/contribution-fee', methods=['GET', 'POST'])
def contribution_fee():
    
    events = db.session.query(Contributions.contribution_event).scalar()
    print(events)

    return 'OKE'
    
@admin_bp.route('/payment')
def payment():
    amount = 100000
    vnp_Amount = amount*100
    vnp_IpAddr = getIP()
    vnp_OrderInfo = 'TEST CHUC NANG THANH TOAN'
    CreateDate = datetime.now()
    ExpireDate = CreateDate + timedelta(minutes = 10)
    vnp_CreateDate = CreateDate.strftime('%Y%m%d%H%M%S')
    vnp_ExpireDate = ExpireDate.strftime('%Y%m%d%H%M%S')

    return redirect(url_for('pay.payment', vnp_Amount=vnp_Amount, vnp_IpAddr=vnp_IpAddr, vnp_OrderInfo=vnp_OrderInfo, vnp_CreateDate=vnp_CreateDate, vnp_ExpireDate=vnp_ExpireDate))
    



def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth_header = request.headers.get('Authorization')
        if auth_header and auth_header.startswith('Bearer '):
            token = auth_header.split(' ')[1]
        else:
            return jsonify({'message': 'Token is missing'}), 401

        try:
            data = jwt.decode(token, current_app.config['SECRET_KEY'], algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            return jsonify({'message': 'Token has expired'}), 401
        except jwt.InvalidTokenError:
            return jsonify({'message': 'Invalid token'}), 401

        return f(data, *args, **kwargs)

    return decorated

@admin_bp.post('/validate<user_id>')
# @token_required
def validate_user(data, user_id):
    role = data.get('is_admin')
    if role == 'false':
        return jsonify({'message': 'user unauthorized'}), 403
    
    full_name = request.form.get('full_name')
    dob = datetime.strptime(request.form.get('date_of_birth'),'%Y-%m-%d').date()
    id_number = request.form.get('id_number')
    status = request.form.get('status')
    room = request.form.get('room')
    # phone_number = request.form.get('phone_number')
    
    new_resident = Residents(
        resident_name = full_name,
        date_of_birth = dob,
        id_number = id_number,
        
    )
    # user = Users.query.filter_by(user_id = user_id).one_or_none()
    # user.set
    
@admin_bp.get('/residents')
# @token_required
def show_all_residents():
    residents = Residents.query.all()
    resident_list = []
    year = datetime.today().year
    for resident in residents:
        age = year - resident.date_of_birth.year
        resident_data = {
            'full_name' : resident.resident_name,
            'date_of_birth' : resident.date_of_birth,
            'id_number' : resident.id_number,
            'age' : age,
            'room' : resident.household_id
        }
        resident_list.append(resident_data)
    return jsonify({'resident_info': resident_list}),200

@admin_bp.get('/house<apartment_number>')
def show_house_info(apartment_number):
    apartment = Households.query.filter_by(apartment_number = apartment_number).first()
    pop = apartment.num_residents
    if pop == 0:
        status = 'empty'
    else: 
        status = 'occupied'   
    apartment_data = {
        'area': apartment.area,
        'status': status,
        'owner': apartment.managed_by,
        'num_residents': pop
    }
    return jsonify({'info': apartment_data}), 200

@admin_bp.post('/update<id>')
def update_info(id):
    int_id = int(id)
    if int_id < 1000:
        apartment = Households.query.filter_by(apartment_number = id).first()
        if not apartment:
            return jsonify({'message': 'Household not found'}), 404
        
        print(request.form)  
        print(request.form.get('household_name'))
        data = {
            'household_name' : request.form.get('household_name'),
            'phone_number' : request.form.get('phone_number'),
            'num_residents' : request.form.get('num_residents')    
        }
        for field, value in data.items():
            if value is not None:
                setattr(apartment, field, value)
        try:
            db.session.commit()
            return jsonify({'message': 'Household updated successfully'}), 200
        except Exception as e:
            db.session.rollback()
            return jsonify({'message': f'An error occurred: {str(e)}'}), 500
    else:
        resident = Residents.query.filter_by(id_number = id).first()
        if not resident:
            return jsonify({'message': 'Resident not found'}), 404 
        data = {
            'resident_name' : request.form.get('resident_name'),
            'phone_number' : request.form.get('phone_number'),
            'status' : request.form.get('status')
        }
        return 200