from db import db

class GameModel(db.Model):
    __tablename__ = 'games'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80))
    thumbnail = db.Column(db.String(300))
    game_url = db.Column(db.String(300))
    genre = db.Column(db.String(20))
    short_description = db.Column(db.String(300))
    platform = db.Column(db.String(80))
    release_date = db.Column(db.String(15))

    def __init__(self, id, title, thumbnail, game_url, genre, short_description,  platform, release_date, **kwargs):
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.game_url = game_url
        self.genre = genre.lower()
        self.short_description = short_description
        self.platform = platform.lower()
        self.release_date = release_date

    def save_to_db(self):
        db.session.merge(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()

    @classmethod
    def find_by_category(cls, category):
        return cls.query.filter_by(genre=category).all()

    @classmethod
    def find_by_platform(cls, platform):
        return cls.query.filter_by(platform=platform).all()

    @classmethod
    def find_by_name(cls, name):
        return cls.query.filter_by(title=name).first()

    @classmethod
    def find_by_id(cls, id):
        return cls.query.filter_by(id=id).first()

    @classmethod
    def find_all(cls):
        return cls.query.all()




