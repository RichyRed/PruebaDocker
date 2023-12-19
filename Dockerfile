# Usa la imagen oficial de Python 3.11
FROM python:3.11-slim

# Define un argumento para la clave de OpenAI
ARG OPENAI_KEY
ENV OPENAI_KEY=$OPENAI_KEY

# Define el puerto de la aplicación
ENV PORT 8000

# Instala spaCy y las dependencias necesarias
RUN pip install -U spacy
RUN python -m spacy download es_core_news_md

# Instala las dependencias de TensorFlow y scikit-learn
RUN pip install tensorflow scikit-learn

# Instala otras dependencias desde requirements.txt
COPY requirements.txt /
RUN pip install -r requirements.txt

# Copia los archivos necesarios
COPY predictor.py /
COPY localizador.py /
COPY information.py /
COPY app.py /
COPY requirements.txt /
COPY db.sqlite3 /
COPY list.txt /
COPY src /src

# Define el directorio de trabajo
WORKDIR /src

# CMD para ejecutar la aplicación con uvicorn
CMD uvicorn app:app --host 0.0.0.0 --port ${PORT}
