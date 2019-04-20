FROM python:3.7-slim
ENV PYTHONUNBUFFERED 1
ARG REQS=--no-dev

ENV VIRTUAL_ENV=/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apt-get update && apt-get install -y curl poppler-utils binutils \
                       autoconf automake libtool \
                       libpng-dev \
                       g++ \
                       libtiff-dev \
                       libopencv-dev libtesseract-dev \
                       tesseract-ocr \
                       git \
                       cmake \
                       build-essential \
                       libleptonica-dev \
                       liblog4cplus-dev \
                       libcurl4-openssl-dev \
                       wget
                       # wget \
                       # tk8.5 tcl8.5 tk8.5-dev tcl8.5-dev

RUN wget http://www.leptonica.com/source/leptonica-1.77.0.tar.gz && \
        tar -zxvf leptonica-1.77.0.tar.gz && \
        cd leptonica-1.77.0/ && \
        ./configure && \
        make && \
        make install && \
        ldconfig

RUN echo 'alias venv="source /venv/bin/activate"' >> ~/.bashrc
# Add virtualenv to bash prompt
RUN echo 'if [ -z "${VIRTUAL_ENV_DISABLE_PROMPT:-}" ] ; then \n\
              _OLD_VIRTUAL_PS1="${PS1:-}" \n\
              if [ "x(venv) " != x ] ; then \n\
          	PS1="(venv) ${PS1:-}" \n\
              else \n\
              if [ "`basename \"$VIRTUAL_ENV\"`" = "__" ] ; then \n\
                  # special case for Aspen magic directories \n\
                  # see http://www.zetadev.com/software/aspen/ \n\
                  PS1="[`basename \`dirname \"$VIRTUAL_ENV\"\``] $PS1" \n\
              else \n\
                  PS1="(`basename \"$VIRTUAL_ENV\"`)$PS1" \n\
              fi \n\
              fi \n\
              export PS1 \n\
          fi' >> ~/.bashrc

# Set up virtual environment
RUN pip install pip tesserocr bpython --upgrade && \
    apt-get install -y --no-install-recommends gcc libffi-dev libmagic1 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove gcc libffi-dev

WORKDIR /code

CMD /bin/bash
