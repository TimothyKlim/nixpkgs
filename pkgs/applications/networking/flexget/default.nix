{ lib, python3Packages }:

python3Packages.buildPythonApplication rec {
  pname = "FlexGet";
  version = "3.1.116";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "6372b36495ae023bd64ce28ca649feba54b060ed8f0a5f606a4845974e834493";
  };

  postPatch = ''
    # remove dependency constraints
    sed 's/==\([0-9]\.\?\)\+//' -i requirements.txt

    # "zxcvbn-python" was renamed to "zxcvbn", and we don't have the former in
    # nixpkgs. See: https://github.com/NixOS/nixpkgs/issues/62110
    substituteInPlace requirements.txt --replace "zxcvbn-python" "zxcvbn"
  '';

  # ~400 failures
  doCheck = false;

  propagatedBuildInputs = with python3Packages; [
    # See https://github.com/Flexget/Flexget/blob/master/requirements.in
    APScheduler
    beautifulsoup4
    cherrypy
    colorama
    colorclass
    feedparser
    flask-compress
    flask-cors
    flask_login
    flask-restful
    flask-restx
    flask
    guessit
    html5lib
    jinja2
    jsonschema
    loguru
    more-itertools
    progressbar
    pynzb
    pyparsing
    PyRSS2Gen
    dateutil
    pyyaml
    rebulk
    requests
    rpyc
    sgmllib3k
    sqlalchemy
    terminaltables
    zxcvbn
    psutil
    # plugins
    transmission-rpc
  ];

  meta = with lib; {
    homepage    = "https://flexget.com/";
    description = "Multipurpose automation tool for all of your media";
    license     = licenses.mit;
    maintainers = with maintainers; [ marsam ];
  };
}
