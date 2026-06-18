(async function () {

    const token =
        localStorage.getItem("token") ||
        sessionStorage.getItem("token");

    if (!token) {
        window.location.href = "login.html";
        return;
    }

    try {

        const response = await fetch(
            "http://localhost:8081/auth/me",
            {
                headers: {
                    Authorization: "Bearer " + token
                }
            }
        );

        console.log("Auth Me Status:", response.status);

        if (!response.ok) {
            window.location.href = "login.html";
            return;
        }

        const user = await response.json();

        if (user.role !== "ADMIN") {
            window.location.href = "403.html";
            return;
        }

    } catch (error) {
        console.error(error);
        window.location.href = "login.html";
    }

})();

// const token =
//     localStorage.getItem("token") ||
//     sessionStorage.getItem("token");

// console.log("Token Found:", token);

// if (!token) {
//     window.location.href = "login.html";
// }