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

    def __init__(self,id, title, thumbnail, game_url, genre,short_description,  platform):
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.game_url = game_url
        self.genre = genre
        self.short_description = short_description
        self.platform = platform




